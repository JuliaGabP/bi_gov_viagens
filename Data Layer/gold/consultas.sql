-- 1. Top 10 viagens mais caras
SELECT
    fv.srk_fat_vgm,
    vjt.nom_vjt,
    orgs.nom_org_sol,
    tmp.ano,
    fv.tot_gas
FROM dw_gold.fat_vgm fv
JOIN dw_gold.dim_vjt vjt      ON fv.srk_vjt = vjt.srk_vjt
JOIN dw_gold.dim_org_sol orgs ON fv.srk_org_sol = orgs.srk_org_sol
JOIN dw_gold.dim_tmp tmp      ON fv.srk_tmp = tmp.srk_tmp
ORDER BY fv.tot_gas DESC
LIMIT 10;

-- 2. Top 5 viajantes com mais viagens
SELECT
    vjt.nom_vjt,
    COUNT(fv.srk_fat_vgm) AS qtd_vgm
FROM dw_gold.fat_vgm fv
JOIN dw_gold.dim_vjt vjt ON fv.srk_vjt = vjt.srk_vjt
GROUP BY vjt.nom_vjt
ORDER BY qtd_vgm DESC
LIMIT 5;


-- 3. Top 10 viajantes por gasto total
SELECT
    vjt.nom_vjt,
    SUM(fv.tot_gas) AS tot_gas_vjt
FROM dw_gold.fat_vgm fv
JOIN dw_gold.dim_vjt vjt ON fv.srk_vjt = vjt.srk_vjt
GROUP BY vjt.nom_vjt
ORDER BY tot_gas_vjt DESC
LIMIT 10;

-- 4. Gasto total por orgão superior
SELECT
    orgsup.nom_org_sup,
    SUM(fv.tot_gas) AS tot_gas_org_sup
FROM dw_gold.fat_vgm fv
JOIN dw_gold.dim_org_sup orgsup ON fv.srk_org_sup = orgsup.srk_org_sup
GROUP BY orgsup.nom_org_sup
ORDER BY tot_gas_org_sup DESC;

-- 5. Quantidade de viagens por orgão solicitante
SELECT
    orgs.nom_org_sol,
    COUNT(fv.srk_fat_vgm) AS qtd_vgm
FROM dw_gold.fat_vgm fv
JOIN dw_gold.dim_org_sol orgs ON fv.srk_org_sol = orgs.srk_org_sol
GROUP BY orgs.nom_org_sol
ORDER BY qtd_vgm DESC;

-- 6. Gasto total por ano
SELECT
    tmp.ano,
    SUM(fv.tot_gas) AS tot_gas_ano
FROM dw_gold.fat_vgm fv
JOIN dw_gold.dim_tmp tmp ON fv.srk_tmp = tmp.srk_tmp
GROUP BY tmp.ano
ORDER BY tmp.ano;

-- 7. Gasto médio por viagem por orgão superior
SELECT
    orgsup.nom_org_sup,
    ROUND(AVG(fv.tot_gas), 2) AS gas_med_vgm
FROM dw_gold.fat_vgm fv
JOIN dw_gold.dim_org_sup orgsup ON fv.srk_org_sup = orgsup.srk_org_sup
GROUP BY orgsup.nom_org_sup
ORDER BY gas_med_vgm DESC;

-- 8. Total devolvido por orgão superior
SELECT
    orgsup.nom_org_sup,
    SUM(fv.vlr_dvl) AS ttl_dvl
FROM dw_gold.fat_vgm fv
JOIN dw_gold.dim_org_sup orgsup ON fv.srk_org_sup = orgsup.srk_org_sup
GROUP BY orgsup.nom_org_sup
ORDER BY ttl_dvl DESC;


-- 9. Orgãos superiores com maior custo médio diário
WITH cte_cst_dia AS (
    SELECT
        srk_org_sup,
        cst_med_dia
    FROM dw_gold.fat_vgm
    WHERE cst_med_dia > 0
)
SELECT
    orgsup.nom_org_sup,
    ROUND(AVG(cte.cst_med_dia), 2) AS med_cst_dia
FROM cte_cst_dia cte
JOIN dw_gold.dim_org_sup orgsup
    ON cte.srk_org_sup = orgsup.srk_org_sup
GROUP BY orgsup.nom_org_sup
ORDER BY med_cst_dia DESC;

-- 10.Relação entre duração da viagem e custo médio diário por órgão superior
WITH cte_vgm_org AS (
    SELECT
        fv.srk_org_sup,
        fv.drc_vgm_dia,
        fv.cst_med_dia
    FROM dw_gold.fat_vgm fv
    WHERE fv.drc_vgm_dia > 0
)
SELECT
    orgsup.nom_org_sup,
    ROUND(AVG(cte.drc_vgm_dia), 1) AS dur_med_vgm_dia,
    ROUND(AVG(cte.cst_med_dia), 2) AS cst_med_dia
FROM cte_vgm_org cte
JOIN dw_gold.dim_org_sup orgsup
    ON cte.srk_org_sup = orgsup.srk_org_sup
GROUP BY orgsup.nom_org_sup
ORDER BY cst_med_dia DESC;
