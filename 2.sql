SELECT
    ag.AGE_CODE AS '年齢コード',
    ag.AGE_NAME AS '年齢階層名',
    SUM(std.SP_TIME_5) AS '5時間未満',
    SUM(std.SP_TIME_6) AS '5時間以上6時間未満',
    SUM(std.SP_TIME_7) AS '6時間以上7時間未満',
    SUM(std.SP_TIME_8) AS '7時間以上8時間未満',
    SUM(std.SP_TIME_9) AS '8時間以上9時間未満',
    SUM(std.SP_TIME_9OVER) AS '9時間以上'
FROM
    SLEEP_TIME_DTL std
    INNER JOIN AGE_GRP ag ON std.AGE_CODE = ag.AGE_CODE
    INNER JOIN PREFECTURE pf ON std.PF_CODE = pf.PF_CODE
WHERE
    pf.PF_NAME in ('北海道', '青森県', '岩手県', '宮城県', '福島県')
GROUP BY
    ag.AGE_CODE
ORDER BY
    ag.AGE_CODE;