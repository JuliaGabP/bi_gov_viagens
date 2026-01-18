-- 1. Total gasto por Órgão Superior (Ranking de gastos)
SELECT 
    os.nome_orgao_superior, 
    SUM(fv.total_gasto) AS gasto_total
FROM gold.fat_viagem fv
JOIN gold.dim_orgao_superior os ON fv.orgao_superior_id = os.orgao_superior_id
GROUP BY os.nome_orgao_superior
ORDER BY gasto_total DESC;

-- 2. Os 5 viajantes que mais geraram custos
SELECT 
    vj.nome, 
    SUM(fv.total_gasto) AS total_gasto_acumulado,
    COUNT(fv.fat_viagem_id) AS quantidade_viagens
FROM gold.fat_viagem fv
JOIN gold.dim_viajante vj ON fv.viajante_id = vj.viajante_id
GROUP BY vj.nome
ORDER BY total_gasto_acumulado DESC
LIMIT 5;

-- 3. Média de custo diário por motivo de viagem
SELECT 
    m.motivo, 
    ROUND(AVG(fv.custo_medio_diario), 2) AS media_custo_diario
FROM gold.fat_viagem fv
JOIN gold.dim_motivo m ON fv.motivo_id = m.motivo_id
GROUP BY m.motivo
ORDER BY media_custo_diario DESC;

-- 4. Evolução mensal dos gastos com passagens e diárias
SELECT 
    t.ano, 
    t.mes_nome, 
    SUM(fv.valor_passagens) AS total_passagens, 
    SUM(fv.valor_diarias) AS total_diarias
FROM gold.fat_viagem fv
JOIN gold.dim_tempo t ON fv.tempo_id = t.tempo_id
GROUP BY t.ano, t.mes_numero, t.mes_nome
ORDER BY t.ano, t.mes_numero;

-- 5. Órgãos solicitantes com maior valor de devolução
SELECT 
    osg.nome_orgao_solicitante, 
    SUM(fv.valor_devolucao) AS total_devolvido
FROM gold.fat_viagem fv
JOIN gold.dim_orgao_solicitante osg ON fv.orgao_solicitante_id = osg.orgao_solicitante_id
GROUP BY osg.nome_orgao_solicitante
ORDER BY total_devolvido DESC;

-- 6. Duração média das viagens por cargo
SELECT 
    vj.cargo, 
    ROUND(AVG(fv.duracao_viagem_dias), 1) AS media_dias_viagem
FROM gold.fat_viagem fv
JOIN gold.dim_viajante vj ON fv.viajante_id = vj.viajante_id
WHERE vj.cargo IS NOT NULL
GROUP BY vj.cargo
ORDER BY media_dias_viagem DESC;

-- 7. Percentual de gastos extras (outros gastos) em relação ao total
SELECT 
    os.nome_orgao_superior,
    SUM(fv.valor_outros_gastos) AS outros_gastos,
    SUM(fv.total_gasto) AS total,
    ROUND((SUM(fv.valor_outros_gastos) / NULLIF(SUM(fv.total_gasto), 0)) * 100, 2) AS percentual_extra
FROM gold.fat_viagem fv
JOIN gold.dim_orgao_superior os ON fv.orgao_superior_id = os.orgao_superior_id
GROUP BY os.nome_orgao_superior
ORDER BY percentual_extra DESC;

-- 8. Identificação de meses com maior volume de viagens
SELECT 
    t.mes_nome, 
    COUNT(fv.fat_viagem_id) AS total_viagens
FROM gold.fat_viagem fv
JOIN gold.dim_tempo t ON fv.tempo_id = t.tempo_id
GROUP BY t.mes_nome, t.mes_numero
ORDER BY total_viagens DESC;

-- 9. Gastos totais detalhados por função de viajante
WITH indicadores_por_funcao AS (
    SELECT
        vj.descricao_funcao,
        COUNT(fv.fat_viagem_id) AS quantidade_viagens,
        SUM(fv.total_gasto) AS gasto_total,
        AVG(fv.total_gasto) AS gasto_medio_por_viagem
    FROM gold.fat_viagem fv
    JOIN gold.dim_viajante vj
        ON fv.viajante_id = vj.viajante_id
    WHERE vj.descricao_funcao IS NOT NULL
    GROUP BY vj.descricao_funcao
)
SELECT
    descricao_funcao,
    quantidade_viagens,
    gasto_total,
    ROUND(gasto_medio_por_viagem, 2) AS gasto_medio_por_viagem
FROM indicadores_por_funcao
ORDER BY gasto_total DESC;

-- 10. Cruzamento de Órgão Superior vs Motivo (Onde se gasta mais e por quê)
WITH indicadores_por_orgao_solicitante AS (
    SELECT
        os.nome_orgao_solicitante,
        COUNT(fv.fat_viagem_id) AS quantidade_viagens,
        SUM(fv.total_gasto) AS gasto_total,
        AVG(fv.total_gasto) AS gasto_medio_por_viagem
    FROM gold.fat_viagem fv
    JOIN gold.dim_orgao_solicitante os
        ON fv.orgao_solicitante_id = os.orgao_solicitante_id
    GROUP BY os.nome_orgao_solicitante
)
SELECT
    nome_orgao_solicitante,
    quantidade_viagens,
    gasto_total,
    ROUND(gasto_medio_por_viagem, 2) AS gasto_medio_por_viagem
FROM indicadores_por_orgao_solicitante
ORDER BY gasto_total DESC;
