
CREATE TABLE IF NOT EXISTS public.categorias
(
    codigo_unico integer NOT NULL DEFAULT nextval('categorias_codigo_unico_seq'::regclass),
    nome_categoria character varying(80) COLLATE pg_catalog."default" NOT NULL,
    CONSTRAINT categorias_pkey PRIMARY KEY (codigo_unico)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.categorias
    OWNER to postgres;



CREATE TABLE IF NOT EXISTS public.metodos_pagamento
(
    codigo_pagamento integer NOT NULL,
    formas_transacao character varying(30) COLLATE pg_catalog."default" NOT NULL,
    CONSTRAINT metodo_pagamento_pkey PRIMARY KEY (codigo_pagamento)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.metodos_pagamento
    OWNER to postgres;


CREATE TABLE IF NOT EXISTS public.funcionarios
(
    cpf character(11) COLLATE pg_catalog."default" NOT NULL,
    nome_completo character varying(80) COLLATE pg_catalog."default" NOT NULL,
    cargo character varying(40) COLLATE pg_catalog."default" NOT NULL,
    login_usuario character varying(20) COLLATE pg_catalog."default" NOT NULL,
    CONSTRAINT funcionarios_pkey PRIMARY KEY (cpf)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.funcionarios
    OWNER to postgres;



CREATE TABLE IF NOT EXISTS public.produtos
(
    codigo_produto integer NOT NULL,
    nome character varying(80) COLLATE pg_catalog."default" NOT NULL,
    valor_unitario numeric(12,2),
    estoque integer NOT NULL,
    codigo_categorias integer NOT NULL,
    CONSTRAINT produtos_pkey PRIMARY KEY (codigo_produto)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.produtos
    OWNER to postgres;
