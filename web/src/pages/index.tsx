import * as React from "react";
import { HashRouter as Router, Route } from "react-router-dom";

import { RwHeader } from "../components/header";
import { RwFooter } from "../components/footer";

import { Settings } from "./settings";
import { Login } from "./login";
import { Home } from "./home";
import { Article } from "./article/index";
import { ArticleEdit } from "./article/edit";
import { Profile } from "./profile";

export function Index(): JSX.Element {
    return (
        <Router>
            <div>
                <RwHeader />
                <Route path="/" exact component={Home} />
                <Route path="/settings" component={Settings} />
                <Route path="/login" component={Login} />
                <Route path="/article/:articleId" component={Article} />
                <Route path="/article/new" component={ArticleEdit} />
                <Route path="/profile/:username" component={Profile} />
                <RwFooter />
            </div>
        </Router>
    );
}
