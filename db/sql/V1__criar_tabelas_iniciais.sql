CREATE EXTENSION postgis

CREATE TABLE OCORRENCIAS (
    id SERIAL PRIMARY KEY,
    descricao VARCHAR(500) NOT NULL,
    dataHora TIMESTAMP NOT NULL DEFAULT NOW()
);

ALTER TABLE OCORRENCIAS
ADD COLUMN id_localizacao int;

CREATE TABLE LOCALIZACAO_OCORRENCIA (
    id SERIAL PRIMARY KEY,
    cep VARCHAR(10) NULL,
    coordenadas GEOGRAPHY(Point, 4326) NOT NULL,
	cidade VARCHAR(100) NULL,
	bairro VARCHAR(100) NULL,
	rua VARCHAR(100) NULL,
	numero int
);

ALTER TABLE OCORRENCIAS
ADD CONSTRAINT fk_ocorrencia_localizacao
FOREIGN KEY (id_localizacao)
REFERENCES LOCALIZACAO_OCORRENCIA (id);

CREATE TABLE ASSALTOS (
    id SERIAL PRIMARY KEY,
    qtd_agressores int NULL,
    possui_arma bool NOT NULL,
	id_ocorrencia int NOT NULL,
	tentativa bool NOT NULL
);

ALTER TABLE ASSALTOS
ADD COLUMN id_tipo_arma int;

ALTER TABLE ASSALTOS
ADD CONSTRAINT fk_ocorrencias_assaltos
FOREIGN KEY (id_ocorrencia)
REFERENCES OCORRENCIAS (id);

CREATE TABLE ROUBOS (
    id SERIAL PRIMARY KEY,
	id_ocorrencia int NOT NULL,
	tentativa bool NOT NULL
);

ALTER TABLE ROUBOS
ADD CONSTRAINT fk_ocorrencias_roubos
FOREIGN KEY (id_ocorrencia)
REFERENCES OCORRENCIAS (id);

CREATE TABLE AGRESSOES (
    id SERIAL PRIMARY KEY,
	qtd_agressores int NULL,
	verbal bool NOT NULL,
	fisica bool NOT NULL,
	id_ocorrencia int NOT NULL
);

ALTER TABLE AGRESSOES
ADD CONSTRAINT fk_ocorrencias_agressoes
FOREIGN KEY (id_ocorrencia)
REFERENCES OCORRENCIAS (id);

CREATE TABLE TIPO_ARMAS (
    id SERIAL PRIMARY KEY,
	nome varchar(100) NOT NULL,
	arma_fogo bool NOT NULL
);

ALTER TABLE ASSALTOS
ADD CONSTRAINT fk_assaltos_tipo_armas
FOREIGN KEY (id_tipo_arma)
REFERENCES TIPO_ARMAS (id);


CREATE TABLE TIPO_BENS (
    id SERIAL PRIMARY KEY,
	nome varchar(100) NOT NULL
);

CREATE TABLE ASSALTOS_TIPO_BENS (
	id_assalto int NOT NULL,
	id_tipo_bem int NOT NULL,

	 -- Define a chave primária composta
    CONSTRAINT pk_assaltos_tipo_bens PRIMARY KEY (id_assalto, id_tipo_bem),

    -- Define as chaves estrangeiras
    CONSTRAINT fk_assalto
        FOREIGN KEY (id_assalto)
        REFERENCES assaltos (id)
        ON DELETE CASCADE,

    CONSTRAINT fk_tipo_bem
        FOREIGN KEY (id_tipo_bem)
        REFERENCES tipo_bens (id)
        ON DELETE CASCADE
	
);

CREATE TABLE ROUBOS_TIPO_BENS (
	id_roubo int NOT NULL,
	id_tipo_bem int NOT NULL,

	 -- Define a chave primária composta
    CONSTRAINT pk_roubos_tipo_bens PRIMARY KEY (id_roubo, id_tipo_bem),

    -- Define as chaves estrangeiras
    CONSTRAINT fk_roubo
        FOREIGN KEY (id_roubo)
        REFERENCES roubos (id)
        ON DELETE CASCADE,

    CONSTRAINT fk_tipo_bem
        FOREIGN KEY (id_tipo_bem)
        REFERENCES tipo_bens (id)
        ON DELETE CASCADE
	
);

