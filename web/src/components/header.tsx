import * as React from "react";

export function RwHeader(): JSX.Element {
  return (
    <nav className="navbar navbar-light">
      <div className="container">
        <a className="navbar-brand" href="index.html">
          Real World
        </a>
        <ul className="nav navbar-nav pull-xs-right">
          <li className="nav-item">
            <a className="nav-link active" href="">
              Home
            </a>
          </li>
          <li className="nav-item">
            <a className="nav-link" href="">
              <i className="ion-compose" />&nbsp;New Post
            </a>
          </li>
          <li className="nav-item">
            <a className="nav-link" href="">
              <i className="ion-gear-a" />&nbsp;Settings
            </a>
          </li>
          <li className="nav-item">
            <a className="nav-link" href="">
              Sign up
            </a>
          </li>
        </ul>
      </div>
    </nav>
  );
}
