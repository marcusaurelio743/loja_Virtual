package br.com.loja_Virtual.enums;

public enum StatusContaReceber {
	PAGAR("pagar"),
	VENCIDA("vencida"),
	ABERTA("aberta"),
	QUITADA("quitada");
	
	private String descricao;
	
	private StatusContaReceber(String descicao) {
		this.descricao = descicao;
	}
	@Override
	public String toString() {
		return this.descricao;
	}
	
	public String getDescricao() {
		return descricao;
	}
}
