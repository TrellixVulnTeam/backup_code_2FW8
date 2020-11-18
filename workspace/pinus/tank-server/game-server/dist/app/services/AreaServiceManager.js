"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
const AreaService_1 = require("./AreaService");
class AreaServiceManager {
    constructor() {
        this.areaServiceMap = new Map();
    }
    add(key, channel) {
        let areaService = new AreaService_1.default(channel);
        return areaService;
    }
    get(key) {
        return this.areaServiceMap.get(key);
    }
}
exports.default = AreaServiceManager;
//# sourceMappingURL=data:application/json;base64,eyJ2ZXJzaW9uIjozLCJmaWxlIjoiQXJlYVNlcnZpY2VNYW5hZ2VyLmpzIiwic291cmNlUm9vdCI6IiIsInNvdXJjZXMiOlsiLi4vLi4vLi4vYXBwL3NlcnZpY2VzL0FyZWFTZXJ2aWNlTWFuYWdlci50cyJdLCJuYW1lcyI6W10sIm1hcHBpbmdzIjoiOztBQUFBLCtDQUF3QztBQUd4QztJQUdJO1FBQ0ksSUFBSSxDQUFDLGNBQWMsR0FBRyxJQUFJLEdBQUcsRUFBdUIsQ0FBQztJQUN6RCxDQUFDO0lBRUQsR0FBRyxDQUFDLEdBQVUsRUFBRSxPQUFnQjtRQUM1QixJQUFJLFdBQVcsR0FBSSxJQUFJLHFCQUFXLENBQUMsT0FBTyxDQUFDLENBQUM7UUFDNUMsT0FBTyxXQUFXLENBQUM7SUFDdkIsQ0FBQztJQUVELEdBQUcsQ0FBQyxHQUFXO1FBQ1gsT0FBTyxJQUFJLENBQUMsY0FBYyxDQUFDLEdBQUcsQ0FBQyxHQUFHLENBQUMsQ0FBQztJQUN4QyxDQUFDO0NBRUo7QUFoQkQscUNBZ0JDIn0=