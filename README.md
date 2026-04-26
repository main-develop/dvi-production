## About the Project

This project is a production-ready full stack web application built to explore modern development practices and tools.

The live application is available at [https://dvi-app.xyz](https://dvi-app.xyz).

## Architecture Overview

- **Frontend**: TypeScript, React, Next.js, and Tailwind CSS serving a responsive user interface
- **Backend**: Django REST Framework powering a user microservice (authentication, user management), scheduled account deletion microservice, and email-sending microservice using Celery and RabbitMQ
- **API Gateway**: Kong Gateway handles routing, rate limiting, CORS, and acts as the centralized entry point
- **Data Layer**: PostgreSQL as the primary database with Redis for caching
- **Infrastructure**:
  - Containerized with Docker Compose and deployed on a Hetzner VPS
  - Protected by a provider-level firewall (Cloudflare and trusted IPs only)
  - Cloudflare handles DNS, CDN, SSL, caching, and DDoS protection
  - Email delivery via Mailgun SMTP
  - Daily encrypted database backups stored on the server

The architecture tries to emphasize security, scalability, and separation of concerns.

![Application Architecture](docs/architecture.jpg)
