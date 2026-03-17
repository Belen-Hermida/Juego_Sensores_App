# 🐧 Tucán Adventure - Flutter Sensor Game

¡Bienvenido a **Tucán Adventure**! Este es un juego interactivo desarrollado en Flutter donde controlas a un carismático tucán utilizando los **sensores de movimiento (acelerómetro)** de tu dispositivo móvil.

## 📝 Descripción del Proyecto
El objetivo del juego es guiar al tucán hacia la meta (el círculo con la bandera) evitando los obstáculos (estrellas) que aparecen aleatoriamente en la pantalla. 

Este proyecto fue creado para la materia de **Programación Móvil** (Octavo Semestre), enfocándose en la implementación de hardware y manejo de estados en tiempo real.

## 🚀 Características
* **Control por Movimiento:** Uso del paquete `sensors_plus` para detectar la inclinación del teléfono.
* **Generación Aleatoria:** Cada vez que alcanzas la meta, los obstáculos y el objetivo se reposicionan automáticamente.
* **Detección de Colisiones:** Lógica matemática para determinar si el tucán toca un objeto o llega a la meta.
* **Interfaz Adaptable:** Diseño minimalista con colores cálidos y assets personalizados.

## 🛠️ Tecnologías Utilizadas
* **Lenguaje:** Dart
* **Framework:** Flutter
* **Plugins:** `sensors_plus` para el acelerómetro.

## 📲 Cómo Jugar
1.  Instala el APK en tu dispositivo Android.
2.  Sujeta el teléfono en posición horizontal o vertical.
3.  **Inclina el dispositivo** hacia adelante, atrás, izquierda o derecha para mover al tucán.
4.  ¡Llega al círculo negro para ganar puntos y generar un nuevo nivel!

## 📂 Instalación para Desarrolladores
Si quieres probar el código fuente:

1. Clona este repositorio:
   ```bash
   git clone [https://github.com/tu-usuario/sensores_app.git](https://github.com/tu-usuario/sensores_app.git)