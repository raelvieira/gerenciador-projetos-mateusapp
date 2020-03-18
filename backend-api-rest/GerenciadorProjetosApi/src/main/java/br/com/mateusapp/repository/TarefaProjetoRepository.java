package br.com.mateusapp.repository;

import br.com.mateusapp.model.StatusTarefa;
import br.com.mateusapp.model.TarefaProjeto;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

@Repository
public interface TarefaProjetoRepository extends JpaRepository<TarefaProjeto, Integer> {
    Page<TarefaProjeto> findByProjeto_Id(int idProjeto, Pageable paginacao);

    @Modifying
    @Query(value = "UPDATE TarefaProjeto t SET t.status = :status WHERE t.id = :idTarefa")
    void atualizaStatus(@Param("idTarefa") Integer id, @Param("status") StatusTarefa finalizada);
}
