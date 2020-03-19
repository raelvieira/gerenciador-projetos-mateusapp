package br.com.mateusapp.controller.response;

public class Erro {
    private String mensagem;
    private String detalhes;

    public Erro(String mensagem, String detalhes) {
        this.mensagem = mensagem;
        this.detalhes = detalhes;
    }

    public String getMensagem() {
        return mensagem;
    }

    public String getDetalhes() {
        return detalhes;
    }
}
