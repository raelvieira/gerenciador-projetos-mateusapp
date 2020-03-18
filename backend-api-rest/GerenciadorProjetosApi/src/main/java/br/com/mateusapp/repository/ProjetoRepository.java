package br.com.mateusapp.repository;

import br.com.mateusapp.model.Projeto;
import br.com.mateusapp.model.StatusProjeto;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

@Repository
public interface ProjetoRepository extends JpaRepository<Projeto, Integer> {
    Page<Projeto> findByTitulo(String tituloProjeto, Pageable paginacao);

    @Query(value = "SELECT COUNT(t) FROM TarefaProjeto t WHERE t.projeto = :projeto AND (t.status <> 'ABERTA')")
    Long countTarefasNaoConcluidas(@Param("projeto") Projeto projeto);

    @Modifying
    @Query(value = "UPDATE Projeto p SET p.status = :status WHERE p.id = :idProjeto")
    void atualizaStatus(@Param("idProjeto") Integer idProjeto, @Param("status") StatusProjeto status);
}
