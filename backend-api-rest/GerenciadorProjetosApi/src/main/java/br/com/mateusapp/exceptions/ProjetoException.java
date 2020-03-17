package br.com.mateusapp.exceptions;

public class ProjetoException extends RuntimeException {

    public ProjetoException() {}

    public ProjetoException(String mensagem) {
        super(mensagem);
    }

    public ProjetoException(Throwable causa) {
        super(causa);
    }

    public ProjetoException(String mensagem, Throwable causa) {
        super(mensagem, causa);
    }
}
