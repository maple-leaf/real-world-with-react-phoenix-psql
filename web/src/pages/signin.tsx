// @format
import * as React from "react";
import { Link } from "react-router-dom";
import { signIn } from "../api";

interface SignInProps {}
interface SingInState {
    errorMessages: string;
    signInFailed: boolean;
    email: string;
    passwd: string;
}

export class SignIn extends React.PureComponent<SignInProps, SingInState> {
    constructor(props: SignInProps) {
        super(props);
        this.state = {
            errorMessages: "用户名或密码不正确，请重试",
            signInFailed: false,
            email: "",
            passwd: ""
        };
    }

    renderErrorMessage() {
        return (
            <ul className="error-messages">
                <li>{this.state.errorMessages}</li>
            </ul>
        );
    }

    render() {
        return (
            <div className="auth-page">
                <div className="container page">
                    <div className="row">
                        <div className="col-md-6 offset-md-3 col-xs-12">
                            <h1 className="text-xs-center">SignIn</h1>
                            <p className="text-xs-center">
                                <Link to="/register">
                                    Don't have an account?
                                </Link>
                            </p>

                            {this.state.signInFailed
                                ? this.renderErrorMessage()
                                : null}

                            <form onSubmit={this.signIn.bind(this)}>
                                <fieldset className="form-group">
                                    <input
                                        className="form-control form-control-lg"
                                        type="text"
                                        placeholder="Email"
                                        onChange={this.onChange.bind(this)}
                                        name="email"
                                        value={this.state.email}
                                    />
                                </fieldset>
                                <fieldset className="form-group">
                                    <input
                                        className="form-control form-control-lg"
                                        type="password"
                                        placeholder="Password"
                                        onChange={this.onChange.bind(this)}
                                        name="passwd"
                                        value={this.state.passwd}
                                    />
                                </fieldset>
                                <button className="btn btn-lg btn-primary pull-xs-right">
                                    Sign In
                                </button>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
        );
    }

    signIn(event: React.FormEvent<HTMLFormElement>) {
        event.preventDefault();
        console.log(this.state);
        console.log(event);
        signIn(this.state)
            .then(() => {
                this.updateState("signInFailed", false);
                alert("sign");
            })
            .catch(() => {
                this.updateState("signInFailed", true);
            });
    }

    updateState(field: string, value: any) {
        this.setState(current => ({
            ...current,
            [field]: value
        }));
    }

    onChange(event: React.FormEvent<HTMLInputElement>) {
        const target = event.currentTarget;
        const name = target.name;
        const value = target.value;
        this.updateState(name, value);
    }
}
