// Agente de teste automatico - simula os cenarios sem GUI

!iniciar_testes.

+!iniciar_testes
    <- .print("========================================");
       .print("INICIANDO TESTES AUTOMATICOS");
       .print("========================================");
       .wait(2000);
       !teste_cenario_1;
       .wait(5000);
       !teste_cenario_2;
       .wait(5000);
       !teste_cenario_3;
       .wait(5000);
       .print("========================================");
       .print("TESTES CONCLUIDOS");
       .print("========================================").

// Cenario 1: Proprietario chega
+!teste_cenario_1
    <- .print("");
       .print("========================================");
       .print("TESTE CENARIO 1: PROPRIETARIO CHEGA");
       .print("========================================");
       .print("Simulando: Jonas detectado na entrada");
       .send(camera, tell, simular_chegada("Jonas", "entrada"));
       .wait(3000).

// Cenario 2: Proprietario sai
+!teste_cenario_2
    <- .print("");
       .print("========================================");
       .print("TESTE CENARIO 2: PROPRIETARIO SAI");
       .print("========================================");
       .print("Simulando: Proprietario saindo");
       .send(camera, tell, simular_saida("saindo", "entrada"));
       .wait(3000).

// Cenario 3: Intruso detectado
+!teste_cenario_3
    <- .print("");
       .print("========================================");
       .print("TESTE CENARIO 3: INTRUSO DETECTADO");
       .print("========================================");
       .print("Simulando: Pessoa desconhecida na sala");
       .send(camera, tell, simular_intruso("Desconhecido", "sala"));
       .wait(3000).
