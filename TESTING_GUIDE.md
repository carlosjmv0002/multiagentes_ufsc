# Smart Home System - Testing Guide

## How to Run the System

```bash
./gradlew run
```

## Testing Scenarios

The system will open GUI windows for each device. Use these windows to simulate the scenarios:

### Scenario 1: Owner Arrives Home

**Steps:**
1. In the **Camera** window:
   - Set "Nome da pessoa" to: `Jonas` (or `Maria` or `Pedro`)
   - Set "Local atual" to: `entrada`
   - Click **OK**

**Expected Behavior:**
- Camera detects known person and prints welcome message
- Door automatically unlocks and opens
- AC adjusts to owner's preferred temperature (22°C for Jonas)
- Lights turn on
- Curtains adjust to preferred level (50% for Jonas)

### Scenario 2: Owner Leaves Home

**Steps:**
1. In the **Camera** window:
   - Set "Nome da pessoa" to: `saindo`
   - Set "Local atual" to: `entrada`
   - Click **OK**

**Expected Behavior:**
- Camera detects owner leaving
- AC turns off
- Lights turn off
- Curtains close
- Door closes and locks automatically

### Scenario 3: Intruder Detected

**Steps:**
1. In the **Camera** window:
   - Set "Nome da pessoa" to: `Desconhecido` (or any name not in the database)
   - Set "Local atual" to: `sala` (or any location)
   - Click **OK**

**Expected Behavior:**
- Camera detects unknown person and triggers SECURITY ALERT
- AC sets extreme temperature (randomly 10°C or 35°C) to make environment uncomfortable
- Lights turn off to disorient intruder
- Curtains close to block view
- Door ensures it's locked
- System prints "MODO DE DEFESA ATIVADO!"

## Known Residents

The following people are registered in the system:
- Jonas (preferred temp: 22°C, lights: on, curtains: 50%)
- Maria
- Pedro

## Manual Device Control

You can also manually control devices through their GUI windows:

- **Camera**: Change person name and location
- **Fechadura**: Use buttons to open/close and lock/unlock
- **Ar Condicionado**: Set current and desired temperature
- **Lampada**: Toggle light on/off
- **Cortina**: Set curtain opening level (0-100%)

## Architecture

The system consists of three main agent groups:

1. **Security Agents**:
   - `camera`: Monitors people and triggers scenarios
   - `fechadura`: Controls door lock and opening

2. **Climate Control Agents**:
   - `ar_condicionado`: Controls temperature

3. **Lighting Control Agents**:
   - `lampada`: Controls lights
   - `cortina`: Controls curtains

All agents communicate via message passing to coordinate their actions.
