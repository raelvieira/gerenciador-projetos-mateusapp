package br.com.mateusapp.service;

import br.com.mateusapp.model.StatusProjeto;
import org.springframework.stereotype.Service;

@Service
public class StatusProjetoService {
    public StatusProjeto getSituacaoIniciado(){
        return getStatusComCodigo("I");
    }

    public StatusProjeto getSituacaoEmAndamento(){
        return getStatusComCodigo("A");
    }

    public StatusProjeto getSituacaoFinalizado(){
        return getStatusComCodigo("F");
    }

    private StatusProjeto getStatusComCodigo(String codigo) {
        StatusProjeto status = new StatusProjeto();
        status.setCodigo(codigo);
        return status;
    }
}
