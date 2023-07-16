# ---- Base Node ----
FROM node:alpine AS build-node
WORKDIR /app
COPY /frontend/package.json .
RUN yarn install
COPY chatbot/frontend .
RUN yarn build

# ---- Python Back-end ----
FROM python:3.9
WORKDIR /app
COPY --from=build-node /app/build /app/static
COPY /backend/requirements.txt .
RUN pip install -r requirements.txt
COPY chatbot/backend .
CMD ["uvicorn", "main:app", "--host", "0.0.0.0", "--port", "80"]
