package br.com.meadote.meadote.controllers;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import br.com.meadote.meadote.models.Pessoa;
import br.com.meadote.meadote.services.PessoaService;

@RestController
@RequestMapping("/api/pessoa")
public class PessoaController {

    @Autowired
    PessoaService pessoaService;

    @GetMapping("")
    public ResponseEntity<List<Pessoa>> findAll() {
        return ResponseEntity.ok(pessoaService.findAll());
    }

    @PostMapping
    public ResponseEntity<Pessoa> savePessoa(@RequestBody Pessoa pessoa) {
        return ResponseEntity.status(HttpStatus.CREATED).body(pessoaService.salvarPessoa(pessoa));
    }

    @GetMapping("{id}")
    public ResponseEntity<Pessoa> findById(@PathVariable int id) {
        return ResponseEntity.status(HttpStatus.CREATED).body(pessoaService.findById(id));
    }

    @PutMapping("{id}")
    public ResponseEntity<Pessoa> update(@RequestBody Pessoa pessoa, @PathVariable int id) {
    
        pessoaService.atualizarPessoa(pessoa, id);

        pessoaService.salvarPessoa(pessoa);

        return ResponseEntity.noContent().build();
    }

    @DeleteMapping("{id}")
    public ResponseEntity<Pessoa> deletePessoa(@PathVariable int id) {
        pessoaService.deletarPessoa(id);
        return ResponseEntity.noContent().build();
    }

}
