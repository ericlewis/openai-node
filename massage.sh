#!/bin/bash

npm install change-package-name --save-dev
npx change-package-name @ericlewis/openai
npm uninstall axios
npm install redaxios
npm install typescript@4 --save-dev

sed -i'' '' "s/import type { AxiosPromise, AxiosInstance, AxiosRequestConfig } from 'axios';/type AxiosPromise<T = any> = Promise<{data: T}>;\ntype AxiosInstance = any;\ntype AxiosRequestConfig = any;\nimport globalAxios from 'redaxios';/g" *.ts
sed -i'' '' "s/import type { AxiosInstance, AxiosResponse } from 'axios';/type AxiosInstance = any;/g" *.ts
sed -i'' '' "s/<T = unknown, R = AxiosResponse<T>>//g" *.ts
sed -i'' '' "s/return axios.request<T, R>(axiosRequestArgs);/return axios.request(axiosRequestArgs);/g" *.ts
sed -i'' '' 's/"target": "es6",/"target": "es2021",\n    "esModuleInterop": true,/g' tsconfig.json
sed -i'' '' '/import globalAxios from '\''axios'\'';/d' *.ts

npm version patch -git-tag-version false
npm run build
npm publish