# Usa una imagen base de Python para tu app
FROM python:3.9-slim

# Establece el directorio de trabajo dentro del contenedor
WORKDIR /app

# Copia e instala las dependencias
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copia el código de la aplicación
COPY app.py .

# Expone el puerto 5000 (usado por Flask en app.py)
EXPOSE 5000

# Comando para iniciar la aplicación
CMD ["python", "app.py"]
