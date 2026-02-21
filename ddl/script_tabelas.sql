CREATE TABLE categorias (
    codigo_unico INTEGER PRIMARY KEY,
    nome_categoria VARCHAR(80) NOT NULL
);



CREATE TABLE metodos_pagamento (
    codigo_pagamento INTEGER PRIMARY KEY,
    formas_transacao VARCHAR(30) NOT NULL
);


CREATE TABLE funcionarios (
    cpf CHARACTER(11) PRIMARY KEY,
    nome_completo VARCHAR(80) NOT NULL,
    cargo VARCHAR(40) NOT NULL,
    login_usuario VARCHAR(20) NOT NULL
);



CREATE TABLE produtos (
   
