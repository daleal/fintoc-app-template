import Vue from 'vue/dist/vue.esm';

const WIDGET_URL = 'https://js.fintoc.com/v1/';

export default class Widget {
  constructor(widget) {
    this._widget = widget;
  }

  static async build({
    holderType,
    product,
    publicKey,
    webhookUrl,
    onSuccess,
    onExit,
  }) {
    await Vue.loadScript(WIDGET_URL);
    const widget = Fintoc.create({
      holderType,
      product,
      publicKey,
      webhookUrl,
      onSuccess,
      onExit,
    });
    return new Widget(widget);
  }

  open() {
    this._widget.open();
  }

  close() {
    this._widget.close();
  }

  destroy() {
    this._widget.destroy();
  }
}
