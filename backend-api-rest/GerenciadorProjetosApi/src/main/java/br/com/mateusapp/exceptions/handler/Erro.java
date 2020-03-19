package br.com.mateusapp.exceptions.handler;

public class Erro {
    private String campoErro;
    private String erro;

    public Erro(String campoErro, String erro) {
        this.campoErro = campoErro;
        this.erro = erro;
    }

    public String getCampoErro() {
        return campoErro;
    }

    public String getErro() {
        return erro;
    }
}
