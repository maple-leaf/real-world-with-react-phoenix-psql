// @format
import * as React from "react";
import { Link } from "react-router-dom";

/** Column properties.  */
export interface HeaderProps {
    /** prop1 description */
    brandText?: string;
}

/*
 * Header Component
 */
export class RwHeader extends React.PureComponent<HeaderProps> {
    /*
     * @desc Header Component
     */
    render() {
        return (
            <nav className="navbar navbar-light">
                <div className="container">
                    <Link className="navbar-brand" to="/">
                        {this.props.brandText || "Real World"}
                    </Link>
                    <a
                        className="navbar-slogan"
                        href="https://github.com/gothinkster/realworld"
                    >
                        realworld github project
                    </a>
                    <ul className="nav navbar-nav pull-xs-right">
                        <li className="nav-item">
                            <Link className="nav-link active" to="/">
                                Home
                            </Link>
                        </li>
                        <li className="nav-item">
                            <Link className="nav-link" to="/article/new">
                                <i className="ion-compose" />&nbsp;New Post
                            </Link>
                        </li>
                        <li className="nav-item">
                            <Link className="nav-link" to="/settings">
                                <i className="ion-gear-a" />&nbsp;Settings
                            </Link>
                        </li>
                        <li className="nav-item">
                            <Link className="nav-link" to="/signin">
                                Sign in
                            </Link>
                        </li>
                    </ul>
                </div>
            </nav>
        );
    }
}
