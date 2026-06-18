INSERT INTO users (nome, email, senha_hash, tipo, criado_em) VALUES
('Aluno A', 'alunoA@email.com', 'hash1', 'aluno', NOW()),
('Aluno B', 'alunoB@email.com', 'hash2', 'aluno', NOW()),
('Docente A', 'docenteA@email.com', 'hash3', 'docente', NOW()),
('Empresa A', 'empresaA@email.com', 'hash4', 'empresa', NOW()),
('Admin A', 'adminA@email.com', 'hash5', 'admin', NOW());

INSERT INTO empresas (user_id, nome_fantasia, cnpj, setor, descricao, ativo) VALUES
(4, 'Tech Alpha', '11111111000111', 'TI', 'Empresa de tecnologia', 1),
(4, 'Agro Beta', '22222222000122', 'Agronegócio', 'Empresa agrícola', 1),
(4, 'Saude Gamma', '33333333000133', 'Saúde', 'Clínica médica', 1),
(4, 'Edu Delta', '44444444000144', 'Educação', 'Cursos técnicos', 1),
(4, 'Log Epsilon', '55555555000155', 'Logística', 'Transporte e entrega', 1);

INSERT INTO turmas (docente_id, nome, area_formativa, instituicao, ano_semestre) VALUES
(3, 'Turma A', 'TI', 'IFMG', '2026/1'),
(3, 'Turma B', 'Engenharia', 'IFMG', '2026/1'),
(3, 'Turma C', 'Administração', 'IFMG', '2026/1'),
(3, 'Turma D', 'Saúde', 'IFMG', '2026/1'),
(3, 'Turma E', 'Agronegócio', 'IFMG', '2026/1');

INSERT INTO alunos_turmas (aluno_id, turma_id) VALUES
(1, 1),
(1, 2),
(2, 1),
(2, 3),
(2, 4);

INSERT INTO desafios (empresa_id, titulo, descricao, area, prazo, recursos, status, criado_em) VALUES
(1, 'App Rural', 'Sistema para produtores', 'TI', '2026-12-01', 'Internet, API', 'aberto', NOW()),
(2, 'Logistica Smart', 'Otimização de entregas', 'Logística', '2026-11-01', 'GPS, dados', 'pendente', NOW()),
(3, 'Saude Digital', 'Telemedicina básica', 'Saúde', '2026-10-01', 'API médica', 'aberto', NOW()),
(4, 'Educa Online', 'Plataforma de cursos', 'Educação', '2026-09-01', 'Vídeos, API', 'aberto', NOW()),
(5, 'Agro IA', 'IA para agricultura', 'Agronegócio', '2026-08-01', 'Dados satélite', 'pendente', NOW());

INSERT INTO desafios_turmas (desafio_id, turma_id) VALUES
(1, 1),
(1, 2),
(2, 2),
(3, 3),
(4, 4);

INSERT INTO equipes (desafio_id, nome, criado_em) VALUES
(1, 'Equipe Alpha', NOW()),
(1, 'Equipe Beta', NOW()),
(2, 'Equipe Gamma', NOW()),
(3, 'Equipe Delta', NOW()),
(4, 'Equipe Epsilon', NOW());

INSERT INTO equipes_membros (equipe_id, aluno_id) VALUES
(1, 1),
(1, 2),
(2, 1),
(3, 2),
(4, 1);

INSERT INTO projetos (equipe_id, status, submetido_em) VALUES
(1, 'em_andamento', NULL),
(2, 'submetido', NOW()),
(3, 'avaliado', NOW()),
(4, 'em_andamento', NULL),
(5, 'submetido', NOW());

INSERT INTO projeto_arquivos (projeto_id, nome_original, caminho_arquivo, tipo, tamanho, enviado_em) VALUES
(1, 'doc1.pdf', '/files/doc1.pdf', 'pdf', 1200, NOW()),
(2, 'img1.png', '/files/img1.png', 'png', 800, NOW()),
(3, 'relatorio.docx', '/files/relatorio.docx', 'docx', 1500, NOW()),
(4, 'slide.pptx', '/files/slide.pptx', 'pptx', 3000, NOW()),
(5, 'video.mp4', '/files/video.mp4', 'mp4', 50000, NOW());

INSERT INTO diario_bordo (projeto_id, aluno_id, conteudo, criado_em) VALUES
(1, 1, 'Inicio do projeto', NOW()),
(1, 2, 'Reunião de equipe', NOW()),
(2, 1, 'Desenvolvimento inicial', NOW()),
(3, 2, 'Testes realizados', NOW()),
(4, 1, 'Progresso do sistema', NOW());

INSERT INTO avaliacoes (projeto_id, avaliador_id, tipo_avaliador, criatividade, autonomia, integracao_tp, impacto, comentario, avaliado_em) VALUES
(1, 3, 'docente', 8, 7, 9, 8, 'Bom projeto', NOW()),
(2, 4, 'empresa', 7, 6, 8, 7, 'Interessante', NOW()),
(3, 3, 'docente', 9, 8, 9, 9, 'Excelente', NOW()),
(4, 4, 'empresa', 6, 7, 6, 7, 'Pode melhorar', NOW()),
(5, 3, 'docente', 8, 8, 8, 8, 'Muito bom', NOW());

INSERT INTO certificados (projeto_id, aluno_id, caminho_pdf, gerado_em) VALUES
(3, 1, '/certs/cert1.pdf', NOW()),
(3, 2, '/certs/cert2.pdf', NOW()),
(2, 1, '/certs/cert3.pdf', NOW()),
(5, 2, '/certs/cert4.pdf', NOW()),
(4, 1, '/certs/cert5.pdf', NOW());