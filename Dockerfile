# ---- Base Node ----
FROM node:14-alpine AS build-node
WORKDIR /app
COPY ./frontend/package.json ./frontend/yarn.lock ./
RUN yarn install
COPY ./frontend/ ./
RUN yarn build

# ---- Python Back-end ----
FROM python:3.9-slim
WORKDIR /app
COPY --from=build-node /app/dist /app/static
COPY ./backend/requirements.txt ./
RUN pip install --upgrade pip && pip install -r requirements.txt
COPY ./backend/ ./
CMD ["uvicorn", "main:app", "--host", "0.0.0.0", "--port", "80"]
