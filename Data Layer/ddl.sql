CREATE TYPE via_urg_enum AS ENUM (
        'SIM',
        'NÃO'
);
CREATE TYPE mes_enum AS ENUM (
    'January',
    'February',
    'March',
    'April',
    'May',
    'June',
    'July',
    'August',
    'September',
    'October',
    'November',
    'December'
);
CREATE TABLE viagem (
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
        nome TEXT,
        cargo TEXT,
        funcao TEXT,
        
        dat_ini DATE,
        dat_fim DATE,
        
        destinos TEXT,
        
        motivo TEXT,
        
        val_dia NUMERIC(14,2),
        val_pas NUMERIC(14,2),
        val_dev NUMERIC(14,2),
        val_out_gas NUMERIC(14,2),
	tot_gas NUMERIC(14,2),
	mes_ida mes_enum,
	mes_vol mes_enum
);

