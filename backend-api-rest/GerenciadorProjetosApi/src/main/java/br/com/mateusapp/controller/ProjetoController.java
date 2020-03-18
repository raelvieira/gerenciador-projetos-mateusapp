package br.com.mateusapp.controller;

import br.com.mateusapp.controller.dto.DetalhesProjetoDto;
import br.com.mateusapp.controller.dto.ProjetoDto;
import br.com.mateusapp.controller.form.ProjetoForm;
import br.com.mateusapp.model.Projeto;
import br.com.mateusapp.service.ProjetoService;
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
import java.util.Objects;
import java.util.Optional;

@RestController
@RequestMapping(value = "/projeto")
@CrossOrigin
public class ProjetoController {
    @Autowired
    private ProjetoService projetoService;

    @PostMapping
    public ResponseEntity<ProjetoDto> criar(@RequestBody @Valid ProjetoForm form, UriComponentsBuilder uriBuilder) {
        Projeto projeto = form.converter();
        projetoService.criar(projeto);

        URI uri = uriBuilder.path("/projeto/{id}").buildAndExpand(projeto.getId()).toUri();
        return ResponseEntity.created( uri ).body(new ProjetoDto(projeto));
    }

    @GetMapping
    public Page<DetalhesProjetoDto> buscarTodos(@RequestParam(required = false) String tituloProjeto,
                                                @PageableDefault(sort = "dataPrevisaoEntrega", direction = Sort.Direction.ASC) Pageable paginacao) {

        Page<Projeto> projetos;

        if(Objects.isNull(tituloProjeto)) {
            projetos = projetoService.buscarTodos(paginacao);
        }else {
            projetos = projetoService.buscarPorTitulo(tituloProjeto, paginacao);
        }

        return DetalhesProjetoDto.converter(projetos);
    }

    @GetMapping("/{id}")
    public ResponseEntity<DetalhesProjetoDto> buscarPor(@PathVariable Integer id) {
        Optional<Projeto> projetoOpt = projetoService.buscar(id);

        if (projetoOpt.isPresent()) return ResponseEntity.ok(new DetalhesProjetoDto(projetoOpt.get()));

        return ResponseEntity.notFound().build();
    }

    @PutMapping("/{id}")
    public ResponseEntity<ProjetoDto> editar(@PathVariable Integer id, @RequestBody @Valid ProjetoForm form) {
        Optional<Projeto> projetoOpt = projetoService.buscar(id);

        if (projetoOpt.isPresent()) {
            Projeto projeto = projetoService.editar(projetoOpt.get(), form.converter());
            return ResponseEntity.ok(new ProjetoDto(projeto));
        }

        return ResponseEntity.notFound().build();
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<?> excluir(@PathVariable Integer id) {
        Optional<Projeto> projetoOpt = projetoService.buscar(id);

        if (projetoOpt.isPresent()) {
            projetoService.excluir(id);
            return ResponseEntity.ok().build();
        }

        return ResponseEntity.notFound().build();
    }

    @PutMapping("/finalizar/{id}")
    public  ResponseEntity<?> finalizar(@PathVariable Integer id) {
        Optional<Projeto> projetoOpt = projetoService.buscar(id);

        if (projetoOpt.isPresent()) {
            projetoService.finalizarProjeto(projetoOpt.get());
            return ResponseEntity.ok().build();
        }

        return ResponseEntity.notFound().build();
    }
}
