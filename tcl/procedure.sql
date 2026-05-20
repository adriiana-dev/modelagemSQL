--RegistrarEmprestimo: Insere um novo registro na tabela de empréstimos e define a data prevista de devolução.

CREATE OR REPLACE PROCEDURE registrar_emprestimo(p_id_livro int, p_id_usuario int, p_dias_prazo int)
 
LANGUAGE plpgsql

AS $procedure$

BEGIN
    
    INSERT INTO emprestimos (id_livro, id_usuario, data_emprestimo, data_devolucao_prevista, status)
    VALUES (p_id_livro, p_id_usuario, CURRENT_DATE, CURRENT_DATE + p_dias_prazo, 'Ativo');
END;
$procedure$
;


--RenovarLivro: Atualiza a data prevista de devolução de um empréstimo ativo.

CREATE OR REPLACE PROCEDURE renovar_livro(p_id_emprestimo int, p_dias_adicionais int)
 
LANGUAGE plpgsql

AS $procedure$

BEGIN
    
    UPDATE emprestimos
    SET data_devolucao_prevista = data_devolucao_prevista + p_dias_adicionais
    WHERE id = p_id_emprestimo AND status = 'Ativo';
END;
$procedure$
;


--CadastrarObraCompleta: Insere simultaneamente um livro, seu autor e sua categoria.

CREATE OR REPLACE PROCEDURE cadastrar_obra_completa(p_titulo_livro varchar, p_nome_autor varchar, p_nome_categoria varchar)
 
LANGUAGE plpgsql

AS $procedure$

DECLARE
    v_id_autor INT;
    v_id_categoria INT;

BEGIN
    
    INSERT INTO autores (nome) VALUES (p_nome_autor) 
    RETURNING id INTO v_id_autor;

    INSERT INTO categorias (nome) VALUES (p_nome_categoria) 
    RETURNING id INTO v_id_categoria;

    INSERT INTO livros (titulo, id_autor, id_categoria)
    VALUES (p_titulo_livro, v_id_autor, v_id_categoria);
END;
$procedure$
;


