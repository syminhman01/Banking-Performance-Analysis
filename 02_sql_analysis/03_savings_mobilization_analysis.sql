-- Kiểm tra tiền gửi, lãi suất bình quân, tỉ lệ kế hoạch và thực tế, nhóm kì hạn
WITH ActualSavings AS (
    SELECT
        kh.MA_CHINHANH,
        YEAR(tk.NGAY_GUI) AS NAM,
        DATEPART(QUARTER, tk.NGAY_GUI) AS QUY,
        SUM(tk.SOTIEN_GUI) AS SOTIEN_GUI,
        SUM(tk.SOTIEN_GUI * tk.LAI_SUAT) 
            / NULLIF(SUM(tk.SOTIEN_GUI), 0) AS LAISUAT_BINHQUAN
    FROM TBL_TIENGUI_TIETKIEM tk
    INNER JOIN TBL_KHACH_HANG kh
        ON tk.MA_KHACHHANG = kh.MA_KHACHHANG
    GROUP BY
        kh.MA_CHINHANH,
        YEAR(tk.NGAY_GUI),
        DATEPART(QUARTER, tk.NGAY_GUI)
),
PlanSavings AS (
    SELECT
        CHINHANH AS MA_CHINHANH,
        NAM,
        QUY,
        ISNULL(SUM(SOTIEN), 0) AS SOTIEN_KEHOACH
    FROM TBL_KEHOACH_HUYDONG
    GROUP BY
        CHINHANH,
        NAM,
        QUY
)
SELECT
    a.NAM,
    a.QUY,
    a.MA_CHINHANH,
    a.SOTIEN_GUI,
    p.SOTIEN_KEHOACH,
    a.LAISUAT_BINHQUAN,
    ISNULL(CAST(
        a.SOTIEN_GUI * 100.0 / NULLIF(p.SOTIEN_KEHOACH, 0)
        AS DECIMAL(10,2)
    ), 0) AS TILE_HOANTHANH_KEHOACH
FROM ActualSavings a
LEFT JOIN PlanSavings p
    ON a.MA_CHINHANH = p.MA_CHINHANH
    AND a.NAM = p.NAM
    AND a.QUY = p.QUY
ORDER BY
    a.NAM,
    a.QUY,
    a.MA_CHINHANH;