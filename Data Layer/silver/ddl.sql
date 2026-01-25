DO $$
BEGIN
    IF NOT EXISTS (
        SELECT 1 FROM pg_type WHERE typname = 'via_urg_enum'
    ) THEN
        CREATE TYPE via_urg_enum AS ENUM ('SIM', 'NÃO');
    END IF;
END$$;

CREATE TABLE IF NOT EXISTS viagem (
    ide_pro_via TEXT PRIMARY KEY,    
    nmr_ppt_pcd TEXT,
    situacao TEXT,
    via_urg via_urg_enum,
    jus_urg_via TEXT,
    cod_org_sup INTEGER,
    nom_org_sup TEXT,
    cod_org_sol INTEGER,
    nom_org_sol TEXT,
    cpf_vjt TEXT,
    nome_vjt TEXT,
    cargo TEXT,
    funcao TEXT,
    dat_ini DATE,
    dat_fim DATE,
    destinos TEXT,
    motivo TEXT,
    val_dia NUMERIC(18,2),
    val_pas NUMERIC(18,2),
    val_dev NUMERIC(18,2),
    val_out_gas NUMERIC(18,2),
    tot_gas NUMERIC(18,2),
    mes_ida SMALLINT CHECK (mes_ida BETWEEN 1 AND 12),
    mes_vol SMALLINT CHECK (mes_vol BETWEEN 1 AND 12)
);

