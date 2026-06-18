CREATE DATABASE IF NOT EXISTS conectaEPT
CHARACTER SET utf8mb4
COLLATE utf8mb4_unicode_ci;

USE conectaEPT;

CREATE TABLE users (
    id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(255) NOT NULL,
    email VARCHAR(255) NOT NULL UNIQUE,
    senha_hash VARCHAR(255) NOT NULL,
    tipo ENUM('aluno','docente','empresa','admin') NOT NULL,
    criado_em DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB;

CREATE TABLE empresas (
    id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    user_id BIGINT UNSIGNED NOT NULL,
    nome_fantasia VARCHAR(255) NOT NULL,
    cnpj CHAR(14) NOT NULL UNIQUE,
    setor VARCHAR(150) NOT NULL,
    descricao TEXT,
    ativo BOOLEAN NOT NULL DEFAULT TRUE,
    CONSTRAINT fk_empresas_user
        FOREIGN KEY (user_id)
        REFERENCES users(id)
        ON UPDATE CASCADE
        ON DELETE RESTRICT
) ENGINE=InnoDB;

CREATE TABLE turmas (
    id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    docente_id BIGINT UNSIGNED NOT NULL,
    nome VARCHAR(255) NOT NULL,
    area_formativa VARCHAR(255) NOT NULL,
    instituicao VARCHAR(255) NOT NULL,
    ano_semestre VARCHAR(20) NOT NULL,
    CONSTRAINT fk_turmas_docente
        FOREIGN KEY (docente_id)
        REFERENCES users(id)
        ON UPDATE CASCADE
        ON DELETE RESTRICT
) ENGINE=InnoDB;

CREATE TABLE alunos_turmas (
    id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    aluno_id BIGINT UNSIGNED NOT NULL,
    turma_id BIGINT UNSIGNED NOT NULL,
    CONSTRAINT fk_alunos_turmas_aluno
        FOREIGN KEY (aluno_id)
        REFERENCES users(id)
        ON UPDATE CASCADE
        ON DELETE CASCADE,
    CONSTRAINT fk_alunos_turmas_turma
        FOREIGN KEY (turma_id)
        REFERENCES turmas(id)
        ON UPDATE CASCADE
        ON DELETE CASCADE,
    UNIQUE KEY uk_aluno_turma (aluno_id, turma_id)
) ENGINE=InnoDB;

CREATE TABLE desafios (
    id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    empresa_id BIGINT UNSIGNED NOT NULL,
    titulo VARCHAR(255) NOT NULL,
    descricao TEXT NOT NULL,
    area VARCHAR(255) NOT NULL,
    prazo DATE NOT NULL,
    recursos TEXT,
    status ENUM('pendente','aberto','encerrado') NOT NULL DEFAULT 'pendente',
    criado_em DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_desafios_empresa
        FOREIGN KEY (empresa_id)
        REFERENCES empresas(id)
        ON UPDATE CASCADE
        ON DELETE RESTRICT
) ENGINE=InnoDB;

CREATE TABLE desafios_turmas (
    id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    desafio_id BIGINT UNSIGNED NOT NULL,
    turma_id BIGINT UNSIGNED NOT NULL,
    CONSTRAINT fk_desafios_turmas_desafio
        FOREIGN KEY (desafio_id)
        REFERENCES desafios(id)
        ON UPDATE CASCADE
        ON DELETE CASCADE,
    CONSTRAINT fk_desafios_turmas_turma
        FOREIGN KEY (turma_id)
        REFERENCES turmas(id)
        ON UPDATE CASCADE
        ON DELETE CASCADE,
    UNIQUE KEY uk_desafio_turma (desafio_id, turma_id)
) ENGINE=InnoDB;

CREATE TABLE equipes (
    id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    desafio_id BIGINT UNSIGNED NOT NULL,
    nome VARCHAR(255) NOT NULL,
    criado_em DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_equipes_desafio
        FOREIGN KEY (desafio_id)
        REFERENCES desafios(id)
        ON UPDATE CASCADE
        ON DELETE CASCADE
) ENGINE=InnoDB;

CREATE TABLE equipes_membros (
    id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    equipe_id BIGINT UNSIGNED NOT NULL,
    aluno_id BIGINT UNSIGNED NOT NULL,
    CONSTRAINT fk_equipes_membros_equipe
        FOREIGN KEY (equipe_id)
        REFERENCES equipes(id)
        ON UPDATE CASCADE
        ON DELETE CASCADE,
    CONSTRAINT fk_equipes_membros_aluno
        FOREIGN KEY (aluno_id)
        REFERENCES users(id)
        ON UPDATE CASCADE
        ON DELETE CASCADE,
    UNIQUE KEY uk_equipe_aluno (equipe_id, aluno_id)
) ENGINE=InnoDB;

CREATE TABLE projetos (
    id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    equipe_id BIGINT UNSIGNED NOT NULL,
    status ENUM('em_andamento','submetido','avaliado') NOT NULL DEFAULT 'em_andamento',
    submetido_em DATETIME NULL,
    CONSTRAINT fk_projetos_equipe
        FOREIGN KEY (equipe_id)
        REFERENCES equipes(id)
        ON UPDATE CASCADE
        ON DELETE CASCADE
) ENGINE=InnoDB;

CREATE TABLE projeto_arquivos (
    id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    projeto_id BIGINT UNSIGNED NOT NULL,
    nome_original VARCHAR(255) NOT NULL,
    caminho_arquivo VARCHAR(500) NOT NULL,
    tipo VARCHAR(100) NOT NULL,
    tamanho BIGINT UNSIGNED NOT NULL,
    enviado_em DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_projeto_arquivos_projeto
        FOREIGN KEY (projeto_id)
        REFERENCES projetos(id)
        ON UPDATE CASCADE
        ON DELETE CASCADE
) ENGINE=InnoDB;

CREATE TABLE diario_bordo (
    id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    projeto_id BIGINT UNSIGNED NOT NULL,
    aluno_id BIGINT UNSIGNED NOT NULL,
    conteudo TEXT NOT NULL,
    criado_em DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_diario_bordo_projeto
        FOREIGN KEY (projeto_id)
        REFERENCES projetos(id)
        ON UPDATE CASCADE
        ON DELETE CASCADE,
    CONSTRAINT fk_diario_bordo_aluno
        FOREIGN KEY (aluno_id)
        REFERENCES users(id)
        ON UPDATE CASCADE
        ON DELETE CASCADE
) ENGINE=InnoDB;

CREATE TABLE avaliacoes (
    id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    projeto_id BIGINT UNSIGNED NOT NULL,
    avaliador_id BIGINT UNSIGNED NOT NULL,
    tipo_avaliador ENUM('empresa','docente') NOT NULL,
    criatividade TINYINT UNSIGNED NOT NULL,
    autonomia TINYINT UNSIGNED NOT NULL,
    integracao_tp TINYINT UNSIGNED NOT NULL,
    impacto TINYINT UNSIGNED NOT NULL,
    comentario TEXT,
    avaliado_em DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_avaliacoes_projeto
        FOREIGN KEY (projeto_id)
        REFERENCES projetos(id)
        ON UPDATE CASCADE
        ON DELETE CASCADE,
    CONSTRAINT fk_avaliacoes_avaliador
        FOREIGN KEY (avaliador_id)
        REFERENCES users(id)
        ON UPDATE CASCADE
        ON DELETE RESTRICT,
    CONSTRAINT chk_criatividade
        CHECK (criatividade BETWEEN 0 AND 10),
    CONSTRAINT chk_autonomia
        CHECK (autonomia BETWEEN 0 AND 10),
    CONSTRAINT chk_integracao_tp
        CHECK (integracao_tp BETWEEN 0 AND 10),
    CONSTRAINT chk_impacto
        CHECK (impacto BETWEEN 0 AND 10)
) ENGINE=InnoDB;

CREATE TABLE certificados (
    id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    projeto_id BIGINT UNSIGNED NOT NULL,
    aluno_id BIGINT UNSIGNED NOT NULL,
    caminho_pdf VARCHAR(500) NOT NULL,
    gerado_em DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_certificados_projeto
        FOREIGN KEY (projeto_id)
        REFERENCES projetos(id)
        ON UPDATE CASCADE
        ON DELETE CASCADE,
    CONSTRAINT fk_certificados_aluno
        FOREIGN KEY (aluno_id)
        REFERENCES users(id)
        ON UPDATE CASCADE
        ON DELETE CASCADE
) ENGINE=InnoDB;

DELIMITER $$

-- =====================================================
-- 1. Limite de 4 membros por equipe
-- =====================================================

CREATE TRIGGER trg_limite_membros_equipe
BEFORE INSERT ON equipes_membros
FOR EACH ROW
BEGIN
    DECLARE qtd_membros INT;

    SELECT COUNT(*)
    INTO qtd_membros
    FROM equipes_membros
    WHERE equipe_id = NEW.equipe_id;

    IF qtd_membros >= 4 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Uma equipe pode possuir no máximo 4 membros.';
    END IF;
END$$


-- =====================================================
-- 2. Impedir avaliação duplicada
-- =====================================================

CREATE TRIGGER trg_avaliacao_unica
BEFORE INSERT ON avaliacoes
FOR EACH ROW
BEGIN
    DECLARE qtd_avaliacoes INT;

    SELECT COUNT(*)
    INTO qtd_avaliacoes
    FROM avaliacoes
    WHERE projeto_id = NEW.projeto_id
      AND avaliador_id = NEW.avaliador_id;

    IF qtd_avaliacoes > 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Este avaliador já avaliou este projeto.';
    END IF;
END$$


-- =====================================================
-- 3. Preencher data de submissão automaticamente
-- =====================================================

CREATE TRIGGER trg_projeto_submetido
BEFORE UPDATE ON projetos
FOR EACH ROW
BEGIN
    IF NEW.status = 'submetido'
       AND OLD.status <> 'submetido' THEN

        SET NEW.submetido_em = NOW();

    END IF;
END$$


-- =====================================================
-- 4. Empresa inativa não pode criar desafios
-- =====================================================

CREATE TRIGGER trg_empresa_ativa_desafio
BEFORE INSERT ON desafios
FOR EACH ROW
BEGIN
    DECLARE empresa_ativa BOOLEAN;

    SELECT ativo
    INTO empresa_ativa
    FROM empresas
    WHERE id = NEW.empresa_id;

    IF empresa_ativa = FALSE THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Empresa inativa não pode criar desafios.';
    END IF;
END$$

DELIMITER ;