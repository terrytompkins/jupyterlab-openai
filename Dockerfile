# Start from a core jupyterlab-provided image
FROM jupyter/base-notebook:latest

# Maintainer
LABEL maintainer="ttompkins@mindovermodel.com"

# Set working directory in the container
WORKDIR /home/jovyan

# Use root for installing system packages
USER root

# Update system packages
RUN apt-get update && apt-get -y upgrade

# Install git
RUN apt-get install -y git

# Clone the langchain tutorial repository
RUN git clone https://github.com/gkamradt/langchain-tutorials.git

# Install python and pip
RUN apt-get install -y python3-pip

# Copy over your requirements file
COPY requirements.txt ./requirements.txt

# Install python dependencies
RUN pip install --no-cache-dir -r requirements.txt

# Install OpenAI packages
RUN pip install openai langchain

# Set environment variables for OpenAI
# ENV OPENAI_API_KEY=<API-KEY>
# Alternative to hardcoding the api key into the docker image:
# docker run -p 8888:8888 -e OPENAI_API_KEY=<API-KEY> my-workshop-image

# Expose port for jupyterlab
EXPOSE 8888

# Run Jupyterlab
CMD ["jupyter", "lab", "--ip=0.0.0.0", "--allow-root"]
