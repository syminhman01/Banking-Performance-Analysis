-- Kiểm tra tổng giao dịch, inflow, outflow, tỉ lệ liên ngân hàng
SELECT
    COUNT(*) AS TongGiaoDich,
    SUM(CASE WHEN SOTIEN_TANG > 0 THEN SOTIEN_TANG ELSE 0 END) AS Inflow,
    SUM(CASE WHEN SOTIEN_GIAM > 0 THEN SOTIEN_GIAM ELSE 0 END) AS Outflow,
    CAST(SUM(CASE WHEN LOAI_CK = 'out' THEN 1 ELSE 0 END) AS FLOAT) * 100 / COUNT(*) AS TiLeLienNganHang
FROM TBL_TIENGUI_THANHTOAN;