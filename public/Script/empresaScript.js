// --- Elementos do Modal 1 (Adicionar Informações) ---
const abrirModal = document.getElementById('abrirModal');
const fecharModal = document.getElementById('fecharModal');
const modalOverlay = document.getElementById('modalOverlay');
const btnSalvarInfo = document.getElementById('salvar');

// Elementos de Feedback Visual na Tela Inicial
const avisoPulsante = document.getElementById('avisoPulsante');
const nomeEmpresaTitulo = document.getElementById('nomeEmpresaTitulo');
const detalhesSubtitulo = document.getElementById('detalhesSubtitulo');

// --- Elementos do Modal 2 (Criar Desafios) ---
const abrirModalDesafio = document.getElementById('abrirModalDesafio');
const fecharModalDesafio = document.getElementById('fecharModalDesafio');
const modalDesafioOverlay = document.getElementById('modalDesafioOverlay');
const btnSalvarDesafio = document.getElementById('salvarDesafio');

// --- Lógica de Abertura / Fechamento dos Modais ---
function gerenciarModal(modal, acao) {
    if (acao === 'abrir') modal.classList.add('ativo');
    if (acao === 'fechar') modal.classList.remove('ativo');
}

abrirModal.addEventListener('click', () => gerenciarModal(modalOverlay, 'abrir'));
fecharModal.addEventListener('click', () => gerenciarModal(modalOverlay, 'fechar'));
modalOverlay.addEventListener('click', (e) => { if (e.target === modalOverlay) gerenciarModal(modalOverlay, 'fechar'); });

abrirModalDesafio.addEventListener('click', () => gerenciarModal(modalDesafioOverlay, 'abrir'));
fecharModalDesafio.addEventListener('click', () => gerenciarModal(modalDesafioOverlay, 'fechar'));
modalDesafioOverlay.addEventListener('click', (e) => { if (e.target === modalDesafioOverlay) gerenciarModal(modalDesafioOverlay, 'fechar'); });

// --- Ação de Salvar Informações (Remoção do aviso amparada por aqui) ---
btnSalvarInfo.addEventListener('click', () => {
    const dadosEmpresa = {
        nomeFantasia: document.getElementById('nomeFantasia').value,
        cnpj: document.getElementById('cnpj').value,
        setor: document.getElementById('setor').value,
        descricao: document.getElementById('descricao').value
    };

    console.log("Dados da Empresa Salvos:", dadosEmpresa);

    // Remove o aviso amarelo pulsante se houver conteúdo adicionado
    if (dadosEmpresa.nomeFantasia.trim() !== "") {
        avisoPulsante.style.display = 'none';
        nomeEmpresaTitulo.textContent = dadosEmpresa.nomeFantasia;
        detalhesSubtitulo.textContent = `Setor: ${dadosEmpresa.setor} | CNPJ: ${dadosEmpresa.cnpj}`;
    } else {
        // Fallback básico caso clique em salvar vazio
        avisoPulsante.style.display = 'none';
    }

    gerenciarModal(modalOverlay, 'fechar');
});

// --- Ação de Salvar Desafio ---
btnSalvarDesafio.addEventListener('click', () => {
    const dadosDesafio = {
        titulo: document.getElementById('tituloDesafio').value,
        descricao: document.getElementById('descricaoDesafio').value,
        area: document.getElementById('areaDesafio').value,
        prazo: document.getElementById('prazoDesafio').value,
        recursos: document.getElementById('recursosDesafio').value
    };

    console.log("Novo Desafio Criado:", dadosDesafio);
    
    // Opcional: Limpar formulário após envio
    document.getElementById('tituloDesafio').value = '';
    document.getElementById('descricaoDesafio').value = '';
    document.getElementById('areaDesafio').value = '';
    document.getElementById('prazoDesafio').value = '';
    document.getElementById('recursosDesafio').value = '';

    gerenciarModal(modalDesafioOverlay, 'fechar');
});

// --- Lógica das Abas de Desafios ---
function alternarTabela(tipoTabela) {
    // Esconde todas as tabelas e remove classe ativa dos botões
    document.querySelectorAll('.tabela-wrapper').forEach(tabela => tabela.classList.remove('ativo'));
    document.querySelectorAll('.aba-btn').forEach(botao => botao.classList.remove('ativa'));

    // Adiciona a classe apenas ao elemento clicado
    document.getElementById(`tabela-${tipoTabela}`).classList.add('ativa');
    
    // Define a aba ativa baseada no clique
    const evento = window.event;
    if (evento && evento.target) {
        evento.target.classList.add('ativa');
    }
}