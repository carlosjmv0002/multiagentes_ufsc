// Curtain agent - Lighting control system

!inicializar_cortina.

+!inicializar_cortina
  <- 	.print("Cortina inicializada.");
  	   	.print("Modo: Teste automatico (sem GUI)");
  	   	+nivel_abertura(0).
  	   	
+ajuste_cortina 
  <-  !!verificar_ajuste.
      
+closed  <-  .print("Close event from GUIInterface").
   
+!verificar_ajuste: nivel_abertura(N) 
 	<-  .print("Nivel de abertura da cortina: ", N).

// Scenario 1: Owner arrives - adjust curtain to preference
+ajustar_cortina(P, Nivel)
	<-  .print("Ajustando cortina para preferencia de ", P, ": ", Nivel, "%");
		!ajustar_nivel(Nivel).

+!ajustar_nivel(Nivel): nivel_abertura(NivelAtual) & NivelAtual == Nivel
	<-  .print("Cortina ja esta no nivel desejado: ", Nivel, "%").

+!ajustar_nivel(0)
	<-  -nivel_abertura(_);
		+nivel_abertura(0);
		.print("Cortina fechada.").

+!ajustar_nivel(100)
	<-  -nivel_abertura(_);
		+nivel_abertura(100);
		.print("Cortina totalmente aberta.").

+!ajustar_nivel(Nivel)
	<-  .print("Ajustando cortina para ", Nivel, "%");
		-nivel_abertura(_);
		+nivel_abertura(Nivel);
		.print("Cortina ajustada para ", Nivel, "%.").

// Scenario 2: Owner leaves - close curtains
+fechar_sistema
	<-  .print("Fechando cortinas...");
		!fechar_cortina.

+!fechar_cortina: nivel_abertura(0)
	<-  .print("Cortina ja estava fechada.").

+!fechar_cortina
	<-  -nivel_abertura(_);
		+nivel_abertura(0);
		.print("Cortina fechada.").

// Scenario 3: Intruder detected - close curtains to block view
+modo_defesa
	<-  .print("MODO DE DEFESA: Fechando cortinas completamente!");
		!fechar_defesa.

+!fechar_defesa: nivel_abertura(0)
	<-  .print("Cortinas ja estavam fechadas.").

+!fechar_defesa
	<-  -nivel_abertura(_);
		+nivel_abertura(0);
		.print("Cortinas fechadas para bloquear visao do intruso!").
