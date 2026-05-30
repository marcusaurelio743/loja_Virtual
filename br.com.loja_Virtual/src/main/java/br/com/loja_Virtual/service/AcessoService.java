package br.com.loja_Virtual.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import br.com.loja_Virtual.model.Acesso;
import br.com.loja_Virtual.repository.AcessoRepository;

@Service
public class AcessoService {
	@Autowired
	private AcessoRepository acessoRepository;
	
	public Acesso salvar(Acesso acesso) {
		return acessoRepository.save(acesso);
	}
}
