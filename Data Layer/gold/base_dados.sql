CREATE SCHEMA IF NOT EXISTS gold;
SET search_path TO gold;

CREATE TABLE dim_tempo (
    tempo_id SERIAL PRIMARY KEY,
    data_inicio DATE NOT NULL,
    ano INTEGER NOT NULL,
    mes_numero INTEGER NOT NULL CHECK (mes_numero BETWEEN 1 AND 12),
    mes_nome TEXT NOT NULL,
    dia_semana_nome TEXT NOT NULL,
    UNIQUE (data_inicio)
);

CREATE TABLE dim_orgao_superior (
    orgao_superior_id SERIAL PRIMARY KEY, 
    codigo_orgao_superior INTEGER NOT NULL,
    nome_orgao_superior TEXT NOT NULL,
    UNIQUE (codigo_orgao_superior)
);

CREATE TABLE dim_orgao_solicitante (
    orgao_solicitante_id SERIAL PRIMARY KEY,
    codigo_orgao_solicitante INTEGER NOT NULL,
    nome_orgao_solicitante TEXT NOT NULL,
    codigo_orgao_superior INTEGER NOT NULL,

    CONSTRAINT fk_osg_osp
        FOREIGN KEY (codigo_orgao_superior)
        REFERENCES dim_orgao_superior (codigo_orgao_superior),

    UNIQUE (codigo_orgao_solicitante)
);

CREATE TABLE dim_viajante (
    viajante_id SERIAL PRIMARY KEY,
    cpf_viajante TEXT NOT NULL,
    nome TEXT NOT NULL,
    cargo TEXT,
    descricao_funcao TEXT,
    UNIQUE (cpf_viajante)
);

CREATE TABLE dim_motivo (
    motivo_id SERIAL PRIMARY KEY,
    motivo TEXT NOT NULL,
    UNIQUE (motivo)
);

CREATE TABLE fat_viagem (
    fat_viagem_id CHAR(64) PRIMARY KEY,

    tempo_id INTEGER NOT NULL,
    orgao_superior_id INTEGER NOT NULL,
    orgao_solicitante_id INTEGER NOT NULL,
    viajante_id INTEGER NOT NULL,
    motivo_id INTEGER,

    valor_diarias NUMERIC(14,2) NOT NULL DEFAULT 0,
    valor_passagens NUMERIC(14,2) NOT NULL DEFAULT 0,
    valor_outros_gastos NUMERIC(14,2) NOT NULL DEFAULT 0,
    valor_devolucao NUMERIC(14,2) NOT NULL DEFAULT 0,
    total_gasto NUMERIC(14,2) NOT NULL,

    duracao_viagem_dias INTEGER NOT NULL,
    custo_medio_diario NUMERIC(14,2) NOT NULL,

    CONSTRAINT fk_vgm_tmp
        FOREIGN KEY (tempo_id)
        REFERENCES dim_tempo (tempo_id),

    CONSTRAINT fk_vgm_osp
        FOREIGN KEY (orgao_superior_id)
        REFERENCES dim_orgao_superior (orgao_superior_id),

    CONSTRAINT fk_vgm_osg
        FOREIGN KEY (orgao_solicitante_id)
        REFERENCES dim_orgao_solicitante (orgao_solicitante_id),

    CONSTRAINT fk_vgm_vjt
        FOREIGN KEY (viajante_id)
        REFERENCES dim_viajante (viajante_id),

    CONSTRAINT fk_vgm_mot
        FOREIGN KEY (motivo_id)
        REFERENCES dim_motivo (motivo_id)
);

CREATE INDEX idx_vgm_tmp ON fat_viagem (tempo_id);
CREATE INDEX idx_vgm_osp ON fat_viagem (orgao_superior_id);
CREATE INDEX idx_vgm_osg ON fat_viagem (orgao_solicitante_id);
CREATE INDEX idx_vgm_vjt ON fat_viagem (viajante_id);
CREATE INDEX idx_vgm_mot ON fat_viagem (motivo_id);

