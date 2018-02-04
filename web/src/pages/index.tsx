import * as React from "react";

import { RwHeader } from "../components/header";
import { RwFooter } from "../components/footer";

export function Index(): JSX.Element {
    return (
        <div>
            <RwHeader />
            <RwFooter />
        </div>
    )
}