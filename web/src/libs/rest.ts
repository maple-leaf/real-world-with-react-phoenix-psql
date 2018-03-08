/*
 * rest.js
 *
 * @desc rest lib based on axios
 * @author fengye
 */

import axios, { AxiosInstance, AxiosRequestConfig } from 'axios';

interface RestEntity {
    get(values:object, params:object): Promise<object>;
    post(values:object, data:object): Promise<object>;
    put(values:object, data:object): Promise<object>;
    delete(values:object): Promise<object>;
};

interface KV {
    [key:string]: any
}

const fillUrlPattern = (urlPattern: string, values: KV): string => {
    const regStr = ':([a-zA-Z0-9_]+?)(?=(/|$))';
    const reg = new RegExp(regStr, 'g');
    return urlPattern.replace(reg, (_ignored:string, field: keyof KV):string => {
        return `${values[field]}`;
    });
};

const Rest = (axiosInstance: AxiosInstance, urlPattern:string): RestEntity => {
    return {
        get(values, params: KV = {}) {
            let url = fillUrlPattern(urlPattern, values);

            const paramStr = Object.keys(params).reduce((str, key: keyof KV) => {
                const pairStr = `${key}=${params[key]}`;
                return str.indexOf('?') !== -1 ? `&${pairStr}` : `?${pairStr}`;
            }, '');

            url += paramStr;
            console.log(url);

            return axiosInstance.get(url);
        },

        post(values, data?) {
            const url = fillUrlPattern(urlPattern, values);

            return axiosInstance.post(url, data);
        },

        put(values, data?) {
            const url = fillUrlPattern(urlPattern, values);

            return axiosInstance.put(url, data);
        },

        delete(values, data?) {
            const url = fillUrlPattern(urlPattern, values);

            return axiosInstance.delete(url, data);
        }
    }
};

/**
 * init
 * @params defaults{Object} - defaults for [axios configure](https://github.com/axios/axios#config-defaults)
 * @returns {RestEntity}
 */
const init = (defaults: AxiosRequestConfig) => {
    const instance = axios.create(defaults);

    return (urlPattern: string): RestEntity => Rest(instance, urlPattern);
};

export default init;
