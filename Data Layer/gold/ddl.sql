CREATE SCHEMA IF NOT EXISTS dw_gold;
SET search_path TO dw_gold;

CREATE TABLE dim_tmp (
    tmp_srk BIGINT PRIMARY KEY,
    dat_ini DATE NOT NULL,
    ano INTEGER NOT NULL,
    mes_num INTEGER NOT NULL CHECK (mes_num BETWEEN 1 AND 12),
    mes_nom TEXT NOT NULL,
    dia_smn_nom TEXT NOT NULL,
    UNIQUE (dat_ini)
);

CREATE TABLE dim_org_sup (
    org_sup_srk BIGINT PRIMARY KEY, 
    cod_org_sup INTEGER NOT NULL,
    nom_org_sup TEXT NOT NULL,
    UNIQUE (cod_org_sup)
);

CREATE TABLE dim_org_sol (
    org_sol_srk BIGINT PRIMARY KEY,
    cod_org_sol INTEGER NOT NULL,
    nom_org_sol TEXT NOT NULL,
    cod_org_sup INTEGER NOT NULL,

    CONSTRAINT fk_osg_osp
        FOREIGN KEY (cod_org_sup)
        REFERENCES dim_org_sup (cod_org_sup),

    UNIQUE (cod_org_sol)
);

CREATE TABLE dim_vjt (
    vjt_srk BIGINT PRIMARY KEY,
    cpf_vjt TEXT NOT NULL,
    nom TEXT NOT NULL,
    cargo TEXT,
    descricao_funcao TEXT
);

CREATE TABLE dim_mtv (
    mtv_srk BIGINT PRIMARY KEY,
    mtv TEXT NOT NULL,
    UNIQUE (mtv)
);

CREATE TABLE fat_vgm (
    fat_vgm_srk BIGINT PRIMARY KEY,

    tmp_srk BIGINT NOT NULL,
    org_sup_srk BIGINT NOT NULL,
    org_sol_srk BIGINT NOT NULL,
    vjt_srk BIGINT NOT NULL,
    mtv_srk BIGINT,

    vlr_dia NUMERIC(14,2) NOT NULL DEFAULT 0,
    vlr_psg NUMERIC(14,2) NOT NULL DEFAULT 0,
    vlr_out NUMERIC(14,2) NOT NULL DEFAULT 0,
    vlr_dvl NUMERIC(14,2) NOT NULL DEFAULT 0,
    tot_gst NUMERIC(14,2) NOT NULL,

    drc_vgm_dia INTEGER NOT NULL,
    cst_med_dia NUMERIC(14,2) NOT NULL,

    CONSTRAINT fk_vgm_tmp
        FOREIGN KEY (tmp_srk)
        REFERENCES dim_tmp (tmp_srk),

    CONSTRAINT fk_vgm_osp
        FOREIGN KEY (org_sup_srk)
        REFERENCES dim_org_sup (org_sup_srk),

    CONSTRAINT fk_vgm_osg
        FOREIGN KEY (org_sol_srk)
        REFERENCES dim_org_sol (org_sol_srk),

    CONSTRAINT fk_vgm_vjt
        FOREIGN KEY (vjt_srk)
        REFERENCES dim_vjt (vjt_srk),

    CONSTRAINT fk_vgm_mtv
        FOREIGN KEY (mtv_srk)
        REFERENCES dim_mtv (mtv_srk)
);

CREATE INDEX idc_vgm_tmp ON fat_vgm (tmp_srk);
CREATE INDEX idc_vgm_osp ON fat_vgm (org_sup_srk);
CREATE INDEX idc_vgm_osg ON fat_vgm (org_sol_srk);
CREATE INDEX idc_vgm_vjt ON fat_vgm (vjt_srk);
CREATE INDEX idc_vgm_mtv ON fat_vgm (mtv_srk);
