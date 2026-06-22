const abrirModal = document.getElementById('abrirModal');
const fecharModal = document.getElementById('fecharModal');
const modal = document.getElementById('modalOverlay');

abrirModal.addEventListener('click', () => {
    modal.classList.add('ativo');
});

fecharModal.addEventListener('click', () => {
    modal.classList.remove('ativo');
});

// Fecha ao clicar fora do modal
modal.addEventListener('click', (e) => {
    if (e.target === modal) {
        modal.classList.remove('ativo');
    }
});

document.getElementById('salvar').addEventListener('click', () => {

    const dados = {
        nomeFantasia: document.getElementById('nomeFantasia').value,
        cnpj: document.getElementById('cnpj').value,
        setor: document.getElementById('setor').value,
        descricao: document.getElementById('descricao').value
    };

    console.log(dados);
    modal.classList.remove('ativo');

});