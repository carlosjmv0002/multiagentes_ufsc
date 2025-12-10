// Camera agent - Security system
// Monitors people entering/leaving the house

// Known residents database
pessoa_conhecida("Jonas").
pessoa_conhecida("Maria").
pessoa_conhecida("Pedro").

// Owner preferences
preferencia_temperatura("Jonas", 22).
preferencia_iluminacao("Jonas", ligada).
preferencia_cortina("Jonas", 50).

!inicializar_camera.

+!inicializar_camera
  <- 	.print("Camera de seguranca inicializada na entrada.");
  	   	.print("Modo: Teste automatico (sem GUI)").
  	   	
+movimento 
  <-  !!verificar_pessoa.
      
+closed  <-  .print("Close event from GUIInterface").

// Scenario 1: Owner arrives home
+!verificar_pessoa: pessoa_presente(P) & local("entrada") & pessoa_conhecida(P)
 	<-  .print("=== BEM-VINDO! ===");
 		.print("Proprietario ", P, " detectado na entrada.");
 		.print("Iniciando protocolo de chegada...");
 		
 		// Notify door agent to unlock and open
 		.send(fechadura, tell, proprietario_chegou(P));
 		
 		// Get owner preferences
 		?preferencia_temperatura(P, Temp);
 		?preferencia_iluminacao(P, EstadoLuz);
 		?preferencia_cortina(P, NivelCortina);
 		
 		// Notify climate control
 		.send(ar_condicionado, tell, ajustar_para_proprietario(P, Temp));
 		
 		// Notify lighting system
 		.send(lampada, tell, ajustar_iluminacao(P, EstadoLuz));
 		.send(cortina, tell, ajustar_cortina(P, NivelCortina));
 		
 		.print("Ambiente configurado para ", P, ".").

// Scenario 2: Owner leaves home
+!verificar_pessoa: pessoa_presente("saindo") & local("entrada")
 	<-  .print("=== SAIDA DETECTADA ===");
 		.print("Proprietario saindo de casa.");
 		.print("Iniciando protocolo de saida...");
 		
 		// Notify all systems to turn off
 		.send(ar_condicionado, tell, desligar_sistema);
 		.send(lampada, tell, desligar_sistema);
 		.send(cortina, tell, fechar_sistema);
 		.send(fechadura, tell, fechar_e_trancar);
 		
 		.print("Casa segura. Todos os sistemas desligados.").

// Scenario 3: Unknown person detected (intruder)
+!verificar_pessoa: pessoa_presente(P) & local(L) & not pessoa_conhecida(P) & P \== "ninguem"
 	<-  .print("!!! ALERTA DE SEGURANCA !!!");
 		.print("INTRUSO DETECTADO: ", P, " no local: ", L);
 		.print("Ativando modo de defesa...");
 		
 		// Activate defense protocol - make environment hostile
 		.send(ar_condicionado, tell, modo_defesa);
 		.send(lampada, tell, modo_defesa);
 		.send(cortina, tell, modo_defesa);
 		.send(fechadura, tell, modo_defesa);
 		
 		.print("MODO DE DEFESA ATIVADO!");
 		.print("Notificacao enviada aos proprietarios.").

// No person detected
+!verificar_pessoa: pessoa_presente("ninguem")
 	<-  .print("Nenhuma pessoa detectada no momento.").

// Comandos de teste automatico (sem GUI)
+simular_chegada(P, L)
	<-  .print(">>> TESTE: Simulando chegada de ", P, " em ", L);
		+pessoa_presente(P);
		+local(L);
		!verificar_pessoa;
		-pessoa_presente(P);
		-local(L).

+simular_saida(P, L)
	<-  .print(">>> TESTE: Simulando saida em ", L);
		+pessoa_presente(P);
		+local(L);
		!verificar_pessoa;
		-pessoa_presente(P);
		-local(L).

+simular_intruso(P, L)
	<-  .print(">>> TESTE: Simulando intruso ", P, " em ", L);
		+pessoa_presente(P);
		+local(L);
		!verificar_pessoa;
		-pessoa_presente(P);
		-local(L).
