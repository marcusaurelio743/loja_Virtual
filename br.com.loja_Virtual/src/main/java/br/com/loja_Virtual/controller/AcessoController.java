package br.com.loja_Virtual.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RestController;

import br.com.loja_Virtual.model.Acesso;
import br.com.loja_Virtual.service.AcessoService;

@RestController
public class AcessoController {
	@Autowired
	private AcessoService acessoService;
	
	@PostMapping("/salvarAcesso")
	public ResponseEntity<Acesso> salvarAcesso(@RequestBody Acesso acesso) {
		Acesso acessoSalvo= acessoService.salvar(acesso);
		
		return new ResponseEntity<Acesso>(acessoSalvo, HttpStatus.OK);
	}
}
