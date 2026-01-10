CREATE TYPE viagem_urgente_enum AS ENUM (
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
CREATE TABLE viagens (
        identificador_processo_viagem TEXT PRIMARY KEY,
        
        numero_proposta_pcdp TEXT,
        
        situacao TEXT,
        
        viagem_urgente viagem_urgente_enum,
        
        justificativa_urgencia_viagem TEXT,
        
        codigo_orgao_superior INTEGER,
        nome_orgao_superior TEXT,
        
        codigo_orgao_solicitante INTEGER,
        nome_orgao_solicitante TEXT,
        
        cpf_viajante TEXT,
        nome TEXT,
        cargo TEXT,
        funcao TEXT,
        
        data_inicio DATE,
        data_fim DATE,
        
        destinos TEXT,
        
        motivo TEXT,
        
        valor_diarias NUMERIC(14,2),
        valor_passagens NUMERIC(14,2),
        valor_devolucao NUMERIC(14,2),
        valor_outros_gastos NUMERIC(14,2),
	total_gasto NUMERIC(14,2),
	mes_ida mes_enum,
	mes_volta mes_enum
);

