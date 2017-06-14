﻿import { MainService } from './main-service';

export class UtilityService {
    MS: MainService;

    constructor(mainservice: MainService) {
        this.MS = mainservice;
    }

    clearSessionStorage(): void {
        window.sessionStorage.clear();
    }

    clone(obj: any): any {
        return JSON.parse(JSON.stringify(obj));
    }

    extractDomain(username: string): string {
        let usernameSplit: string[] = username.split('\\');
        return usernameSplit[0];
    }

    extractUsername(username: string): string {
        let usernameSplit: string[] = username.split('\\');
        return usernameSplit[1];
    }

    generateDailyTriggers(): string[] {
        let dailyTriggers: string[] = [];
        for (let i = 0; i < 24; i++) {
            dailyTriggers.push(`${i}:00`);
            dailyTriggers.push(`${i}:30`);
        }
        return dailyTriggers;
    }

    getItem(key: any): any {
        let item: any = JSON.parse(window.sessionStorage.getItem(key));
        return item;
    }

    getQueryParameter(id: any): string {
        var regex = new RegExp('[?&]' + id.replace(/[\[\]]/g, '\\$&') + '(=([^&#]*)|&|#|$)');
        var results = regex.exec(window.location.href);
        return (!results || !results[2])
            ? ''
            : decodeURIComponent(results[2].replace(/\+/g, ' '));
    }

    getQueryParameterFromUrl(name: any, url: any): string {
        var regex = new RegExp('[?&]' + name.replace(/[\[\]]/g, '\\$&') + '(=([^&#]*)|&|#|$)');
        var results = regex.exec(url);
        return (!results || !results[2])
            ? ''
            : decodeURIComponent(results[2].replace(/\+/g, ' '));
    }

    getUniqueId(characters: number): string {
        return Math.random().toString(36).substr(2, characters + 2);
    }

    isEdge(): boolean {
        return window && window.navigator && window.navigator.userAgent && /Edge\/\d./i.test(window.navigator.userAgent);
    }

    parseCsv(content: string): string[][] {
        let data: string[][] = [];
        let rows: string[] = content.split('\r\n');
        for (let i = 0; i < rows.length; i++) {
            data.push(rows[i].split(','));
        }
        return data;
    }

    readFile(file: File, callback: (result: any) => void): void {
        if (file) {
            let fileReader: FileReader = new FileReader();
            fileReader.onload = (fileContent: any) => {
                callback(fileContent.target.result);
            };
            fileReader.readAsText(file);
        }
    }

    reload(): void {
        if (window && window.location && window.location.reload) {
            window.location.reload();
        }
    }

    removeItem(key: any): void {
        window.sessionStorage.removeItem(key);
    }

    saveItem(key: any, value: any): void {
        let val = JSON.stringify(value);
        if (window.sessionStorage.getItem(key)) {
            window.sessionStorage.removeItem(key);
        }
        window.sessionStorage.setItem(key, val);
    }
}