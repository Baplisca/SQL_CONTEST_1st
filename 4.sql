select
    PF_CODE as '都道府県コード',
    PF_NAME as '都道府県名',
    MAX(
        CASE
            WHEN ra = 1 THEN NATION_NAME
            ELSE NULL
        END
    ) as '1位 国名',
    MAX(
        CASE
            WHEN ra = 1 THEN AMT
            ELSE 0
        END
    ) as '1位 人数',
    MAX(
        CASE
            WHEN ra = 2 THEN NATION_NAME
            ELSE NULL
        END
    ) as '2位 国名',
    MAX(
        CASE
            WHEN ra = 2 THEN AMT
            ELSE 0
        END
    ) as '2位 人数',
    MAX(
        CASE
            WHEN ra = 3 THEN NATION_NAME
            ELSE NULL
        END
    ) as '3位 国名',
    MAX(
        CASE
            WHEN ra = 3 THEN AMT
            ELSE 0
        END
    ) as '3位 人数',
    SUM(AMT) as '合計人数'
from
    (
        select
            p.PF_CODE,
            p.PF_NAME,
            n.NATION_NAME,
            ROW_NUMBER() OVER (
                partition by f.PF_CODE
                order by
                    AMT DESC,
                    f.NATION_CODE
            ) AS ra,
            f.AMT
        from
            FOREIGNER f
            inner join NATIONALITY n on f.NATION_CODE = n.NATION_CODE
            inner join PREFECTURE p on f.PF_CODE = p.PF_CODE
        where
            f.NATION_CODE != '113'
    ) t
group by
    PF_CODE
order by
    SUM(AMT) desc,
    PF_CODE;