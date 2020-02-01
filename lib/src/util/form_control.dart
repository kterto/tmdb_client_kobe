import 'package:flutter/material.dart';

@immutable
class FormControl<T> {
  final String name;
  final T value;
  final bool valid;
  final bool dirty;
  final String errorMessage;
  final List<String Function(T value)> validators;

  FormControl(
      {@required this.name,
      this.value,
      this.valid,
      this.dirty = false,
      this.errorMessage,
      this.validators = const []});

  FormControl<T> onChanged(T value) {
    assert(value is T || value == null);
    for (var validator in validators) {
      String errorMsg = validator(value);
      if (errorMsg != null) {
        return _invalidate(errorMsg, value);
      }
    }
    return _validate(value);
  }

  FormControl<T> reset() {
    return FormControl(
        name: name,
        value: null,
        valid: null,
        dirty: false,
        errorMessage: null,
        validators: validators);
  }

  FormControl<T> _validate(T value) {
    return copyWith(
      value: value,
      valid: true,
      dirty: true,
    );
  }

  FormControl<T> _invalidate(String msg, T value) {
    return copyWith(
      value: value,
      valid: false,
      dirty: true,
      errorMessage: msg,
    );
  }

  FormControl<T> copyWith({
    String name,
    T value,
    bool valid,
    bool dirty,
    String errorMessage,
    List<String Function(T value)> validators,
  }) {
    final _valid = valid ?? this.valid;
    return FormControl(
      name: this.name,
      value: value ?? this.value,
      valid: valid ?? this.valid,
      dirty: dirty ?? this.dirty,
      errorMessage: _valid ? null : errorMessage ?? this.errorMessage,
      validators: validators ?? this.validators,
    );
  }
}
