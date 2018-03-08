import Rest from '../libs/rest';
import axios from 'axios';

const origin = 'http://localhost:4000';
const rest = Rest({
    baseURL: `${origin}/api`
});

console.log(rest);

export const signIn = (data: object) => axios.post(`${origin}/signin`, data);
