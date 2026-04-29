package br.com.loja_Virtual.enums;

public enum StatusContaPagar {
	PAGAR("pagar"),
	VENCIDA("vencida"),
	ABERTA("aberta"),
	QUITADA("quitada"),
	RENEGOCIADA("renegociada");
	
	private String descricao;
	
	private StatusContaPagar(String descicao) {
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
