# Hadoop, YARN, and Spark Docker Setup

This project provides a Docker-based setup for Hadoop, YARN, and Spark on Ubuntu. It allows you to easily deploy and manage a distributed computing environment using containers.

## Project Structure

```
hadoop-spark-docker
├── docker
│   ├── hadoop
│   │   └── Dockerfile
│   ├── spark
│   │   └── Dockerfile
│   └── yarn
│       └── Dockerfile
├── scripts
│   ├── setup-hadoop.sh
│   ├── setup-spark.sh
│   └── setup-yarn.sh
├── docker-compose.yml
├── .env
└── README.md
```

## Prerequisites

- Docker installed on your machine
- Docker Compose installed on your machine

## Setup Instructions

1. Clone the repository:
   ```
   git clone <repository-url>
   cd hadoop-spark-docker
   ```

2. Build the Docker images:
   ```
   docker-compose build
   ```

3. Start the services:
   ```
   docker-compose up
   ```

4. Access the services:
   - Hadoop: http://localhost:9870
   - YARN: http://localhost:8088
   - Spark: http://localhost:8080

## Usage Guidelines

- Use the provided scripts in the `scripts` directory to set up each component individually if needed.
- Modify the `.env` file to customize environment variables such as version numbers and resource limits.

## Contributing

Contributions are welcome! Please open an issue or submit a pull request for any improvements or bug fixes.

## License

This project is licensed under the MIT License. See the LICENSE file for details.