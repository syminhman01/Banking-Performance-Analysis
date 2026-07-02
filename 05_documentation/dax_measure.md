# DAX Measures

## Customer

Tổng khách hàng =
DISTINCTCOUNT(VW_FactCustomerBranch[MA_KHACHHANG])
Khách hàng chi nhánh =
DISTINCTCOUNT(VW_FactCustomerBranch[MA_KHACHHANG])
Khách hàng khu vực =
DISTINCTCOUNT(VW_FactCustomerRegion[MA_KHACHHANG])
Số ngành phục vụ =
CALCULATE(
    DISTINCTCOUNT(VW_FactCustomerBranch[MA_NGANHNGHE]),
    NOT ISBLANK(VW_FactCustomerBranch[MA_NGANHNGHE])
)
## Casa Transaction

Tổng số giao dịch =
COALESCE(
    COUNTROWS(VW_FactCurrentAccountTransaction),
    0
)
Tổng tiền vào =
SUM(VW_FactCurrentAccountTransaction[SOTIENTANG])
Tổng tiền ra =
SUM(VW_FactCurrentAccountTransaction[SOTIENGIAM])
Dòng tiền ròng =
[Tổng tiền vào] - [Tổng tiền ra]
Tỷ lệ liên ngân hàng =
DIVIDE(
    CALCULATE(
        [Tổng số giao dịch],
        VW_FactCurrentAccountTransaction[LOAI_CK] = "out"
    ),
    [Tổng số giao dịch]
)
## Savings
Số tiền tiết kiệm =
SUM(VW_FactSavingsDeposit[SOTIEN_GUI])
Số tài khoản tiết kiệm =
DISTINCTCOUNT(VW_FactSavingsDeposit[MA_TKTK])
Lãi suất bình quân =
DIVIDE(
    SUMX(
        VW_FactSavingsDeposit,
        VW_FactSavingsDeposit[SOTIEN_GUI] * VW_FactSavingsDeposit[LAI_SUAT]
    ),
    SUM(VW_FactSavingsDeposit[SOTIEN_GUI])
) / 100
Tỷ lệ hoàn thành kế hoạch =
DIVIDE(
    [Số tiền tiết kiệm],
    [Số tiền huy động]
)
## Credit
Tổng tiền giải ngân =
SUM(VW_FactLoanContract[SOTIEN_GIAINGAN])
Tổng gốc đã trả =
SUM(VW_FactLoanContract[TRA_GOC])
Tổng lãi suất =
SUM(VW_FactLoanContract[TRA_LAI])
Dư nợ gốc =
[Tổng tiền giải ngân] - [Tổng gốc đã trả]
Tỷ lệ thu hồi gốc =
DIVIDE(
    [Tổng gốc đã trả],
    [Tổng tiền giải ngân]
)
Số khoản vay quá hạn =
VAR ReportDate = DATE(2024, 12, 31)
RETURN
COUNTROWS(
    FILTER(
        VALUES(VW_FactLoanContract[MA_HOPDONG_TINDUNG]),
        VAR DueDate =
            CALCULATE(
                MAX(VW_FactLoanContract[NGAY_DAOHAN])
            )
        RETURN
            DueDate < ReportDate
                && [Dư nợ gốc] > 0
    )
)
## Collateral
Tổng giá trị tài sản =
SUM(VW_FactCollateral[GIATRI_TAISAN])
Tỉ lệ tài sản che phủ dư nợ =
DIVIDE(
    [Tổng giá trị tài sản],
    [Dư nợ gốc]
)
Số hợp đồng thiếu bảo đảm =
COUNTROWS(
    FILTER(
        VALUES(VW_FactCollateral[MA_HOPDONG_TINDUNG]),
        [Dư nợ gốc] > 0
            && COALESCE([Tỉ lệ tài sản che phủ dư nợ], 0) < 1
    )
)