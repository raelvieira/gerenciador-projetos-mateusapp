package br.com.mateusapp.controller;

import br.com.mateusapp.controller.dto.DetalhesTarefaProjetoDto;
import br.com.mateusapp.controller.dto.TarefaProjetoDto;
import br.com.mateusapp.controller.form.TarefaProjetoForm;
import br.com.mateusapp.model.TarefaProjeto;
import br.com.mateusapp.service.ProjetoService;
import br.com.mateusapp.service.TarefaProjetoService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.data.web.PageableDefault;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.util.UriComponentsBuilder;

import javax.validation.Valid;
import java.net.URI;
import java.util.Optional;

@RestController
@RequestMapping(value = "/tarefa")
@CrossOrigin
public class TarefaProjetoController {
    @Autowired
    private TarefaProjetoService tarefaProjetoService;

    @Autowired
    private ProjetoService projetoService;

    @PostMapping
    public ResponseEntity<TarefaProjetoDto> criar(@RequestBody @Valid TarefaProjetoForm form, UriComponentsBuilder uriBuilder) {
        TarefaProjeto tarefa = form.converter(projetoService);
        tarefaProjetoService.criar(tarefa);

        URI uri = uriBuilder.path("/tarefa/{id}").buildAndExpand(tarefa.getId()).toUri();
        return ResponseEntity.created( uri ).body(new TarefaProjetoDto(tarefa));
    }

    @GetMapping
    public Page<DetalhesTarefaProjetoDto> buscarPorProjeto(@RequestParam Integer projetoId,
                                                           @PageableDefault(sort = "dataCriacao", direction = Sort.Direction.ASC) Pageable paginacao) {

        Page<TarefaProjeto> tarefaProjetos = tarefaProjetoService.buscarPorProjeto(projetoId, paginacao);
        return DetalhesTarefaProjetoDto.converter(tarefaProjetos);
    }

    @PutMapping("/{id}")
    public ResponseEntity<TarefaProjetoDto> editar(@PathVariable Integer id, @RequestBody @Valid TarefaProjetoForm form) {
        Optional<TarefaProjeto> tarefaOpt = tarefaProjetoService.buscar(id);

        if(tarefaOpt.isPresent()) {
            TarefaProjeto tarefa = tarefaProjetoService.editar(tarefaOpt.get(), form.converter(projetoService));
            return ResponseEntity.ok(new TarefaProjetoDto(tarefa));
        }

        return ResponseEntity.notFound().build();
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<?> excluir(@PathVariable Integer id) {
        Optional<TarefaProjeto> tarefaOpt = tarefaProjetoService.buscar(id);

        if (tarefaOpt.isPresent()) {
            tarefaProjetoService.exlcuir(id);
            return ResponseEntity.ok().build();
        }

        return ResponseEntity.notFound().build();
    }

    @PutMapping("/finalizar/{id}")
    public  ResponseEntity<?> finalizar(@PathVariable Integer id) {
        Optional<TarefaProjeto> tarefaProjetoOpt = tarefaProjetoService.buscar(id);

        if(tarefaProjetoOpt.isPresent()){
            tarefaProjetoService.finalizarTarefa(tarefaProjetoOpt.get());
            return ResponseEntity.ok().build();
        }

        return ResponseEntity.notFound().build();
    }
}
