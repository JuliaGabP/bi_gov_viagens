CREATE SCHEMA IF NOT EXISTS dw_gold;
SET search_path TO dw_gold;

CREATE TABLE dim_tmp (
    srk_tmp BIGINT PRIMARY KEY,
    dat_ini DATE NOT NULL,
    ano INTEGER NOT NULL,
    mes_num INTEGER NOT NULL CHECK (mes_num BETWEEN 1 AND 12),
    mes_nom TEXT NOT NULL,
    dia_smn_nom TEXT NOT NULL,
    UNIQUE (dat_ini)
);

CREATE TABLE dim_org_sup (
    srk_org_sup BIGINT PRIMARY KEY, 
    cod_org_sup INTEGER NOT NULL,
    nom_org_sup TEXT NOT NULL,
    UNIQUE (cod_org_sup)
);

CREATE TABLE dim_org_sol (
    srk_org_sol BIGINT PRIMARY KEY,
    cod_org_sol INTEGER NOT NULL,
    nom_org_sol TEXT NOT NULL,
    cod_org_sup INTEGER NOT NULL,

    CONSTRAINT fk_osg_osp
        FOREIGN KEY (cod_org_sup)
        REFERENCES dim_org_sup (cod_org_sup),

    UNIQUE (cod_org_sol)
);

CREATE TABLE dim_vjt (
    srk_vjt BIGINT PRIMARY KEY,
    cpf_vjt TEXT NOT NULL,
    nom TEXT NOT NULL,
    cargo TEXT,
    dsc_fun TEXT
);

CREATE TABLE dim_mtv (
    srk_mtv BIGINT PRIMARY KEY,
    mtv TEXT NOT NULL,
    UNIQUE (mtv)
);

CREATE TABLE fat_vgm (
    srk_fat_vgm BIGINT PRIMARY KEY,

    srk_tmp BIGINT NOT NULL,
    srk_org_sup BIGINT NOT NULL,
    srk_org_sol BIGINT NOT NULL,
    srk_vjt BIGINT NOT NULL,
    srk_mtv BIGINT,

    vlr_dia NUMERIC(14,2) NOT NULL DEFAULT 0,
    vlr_psg NUMERIC(14,2) NOT NULL DEFAULT 0,
    vlr_out NUMERIC(14,2) NOT NULL DEFAULT 0,
    vlr_dvl NUMERIC(14,2) NOT NULL DEFAULT 0,
    tot_gst NUMERIC(14,2) NOT NULL,

    drc_vgm_dia INTEGER NOT NULL,
    cst_med_dia NUMERIC(14,2) NOT NULL,

    CONSTRAINT fk_vgm_tmp
        FOREIGN KEY (srk_tmp)
        REFERENCES dim_tmp (srk_tmp),

    CONSTRAINT fk_vgm_osp
        FOREIGN KEY (srk_org_sup)
        REFERENCES dim_org_sup (srk_org_sup),

    CONSTRAINT fk_vgm_osg
        FOREIGN KEY (srk_org_sol)
        REFERENCES dim_org_sol (srk_org_sol),

    CONSTRAINT fk_vgm_vjt
        FOREIGN KEY (srk_vjt)
        REFERENCES dim_vjt (srk_vjt),

    CONSTRAINT fk_vgm_mtv
        FOREIGN KEY (srk_mtv)
        REFERENCES dim_mtv (srk_mtv)
);

CREATE INDEX idc_vgm_tmp ON fat_vgm (srk_tmp);
CREATE INDEX idc_vgm_osp ON fat_vgm (srk_org_sup);
CREATE INDEX idc_vgm_osg ON fat_vgm (srk_org_sol);
CREATE INDEX idc_vgm_vjt ON fat_vgm (srk_vjt);
CREATE INDEX idc_vgm_mtv ON fat_vgm (srk_mtv);
